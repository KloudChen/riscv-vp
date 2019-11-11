#include <assert.h>
#include <err.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdbool.h>

#include "protocol.h"
#include "fns.h"

#define GDB_RUNLEN_CHAR '*'
#define GDB_RUNLEN_OFF 29
#define GDB_RUNLEN_STEP 32
#define GDB_ESCAPE_CHAR '}'
#define GDB_ESCAPE_BYTE 0x20

static int
calc_csum(char *data)
{
	size_t i;
	int csum = 0;

	for (i = 0; i < strlen(data); i++)
		csum += (int)data[i];

	return csum % 256;
}

static char
kind_to_char(gdb_kind_t kind)
{
	switch (kind) {
	case GDB_KIND_NOTIFY:
		return '#';
	case GDB_KIND_PACKET:
		return '$';
	case GDB_KIND_NACK:
		return '-';
	case GDB_KIND_ACK:
		return '+';
	default:
		assert(0);
	}
}

char *
gdb_serialize(gdb_kind_t kind, char *data)
{
	size_t pktlen;
	char *serialized;
	char pktkind;
	int csum, ret;

	pktkind = kind_to_char(kind);
	if (pktkind == GDB_KIND_NACK || pktkind == GDB_KIND_ACK) {
		assert(data == NULL);
		serialized = xmalloc(2); /* kind + nullbyte */

		serialized[0] = pktkind;
		serialized[1] = '\0';

		return serialized;
	}

	csum = calc_csum(data);

	/* + 3 → nullbyte, checksum delimiter, kind */
	pktlen = strlen(data) + GDB_CSUM_LEN + 3;
	serialized = xmalloc(pktlen);

	ret = snprintf(serialized, pktlen, "%c%s#%x", pktkind, data, csum);
	if (ret < 0)
		err(EXIT_FAILURE, "snprintf failed");
	else if ((size_t)ret >= pktlen)
		errx(EXIT_FAILURE, "insufficient snprintf buffer size");

	return serialized;
}

char *
gdb_decode_runlen(char *data)
{
	int rcount, j;
	size_t i, nlen, nrem;
	int runlen;
	char *ndat;

	nlen = 0;
	nrem = strlen(data);
	ndat = xmalloc(nrem);

	for (runlen = -1, i = 0; i < strlen(data); i++) {
		if (data[i] == GDB_RUNLEN_CHAR) {
			if (i <= 0)
				goto err;
			runlen = data[i - 1];
			continue;
		}

		if (runlen == -1) {
			runlen = data[i];
			rcount = 1;
		} else {
			rcount = (int)data[i] - GDB_RUNLEN_OFF;
			if (rcount <= 0)
				goto err;
		}

		for (j = 0; j < rcount; j++) {
			if (nrem-- == 0) {
				ndat = xrealloc(ndat, nlen + GDB_RUNLEN_STEP);
				nrem += GDB_RUNLEN_STEP;
			}
			ndat[nlen++] = runlen;
		}

		runlen = -1;
	}

	/* shrink to actual size */
	ndat = xrealloc(ndat, nlen + 1);
	ndat[nlen] = '\0';

	return ndat;
err:
	free(ndat);
	return NULL;
}

char *
gdb_unescape(char *data)
{
	size_t i, nlen;
	char *ndat;
	bool esc;

	ndat = xmalloc(strlen(data));
	nlen = 0;

	for (esc = false, i = 0; i < strlen(data); i++) {
		if (data[i] == GDB_ESCAPE_CHAR) {
			esc = true;
			continue;
		}

		ndat[nlen++] = (esc) ? data[i] ^ GDB_ESCAPE_BYTE : data[i];
		esc = false;
	}

	/* shrink to actual size */
	ndat = xrealloc(ndat, nlen + 1);
	ndat[nlen] = '\0';

	return ndat;
}

bool
gdb_is_valid(gdb_packet_t *pkt)
{
	int ret;
	int expcsum;
	char strcsum[GDB_CSUM_LEN + 1]; /* +1 for snprintf nullbyte */

	if (!pkt->data)
		return true;
	expcsum = calc_csum(pkt->data);

	ret = snprintf(strcsum, sizeof(strcsum), "%x", expcsum);
	assert(ret == GDB_CSUM_LEN);

	return !strncmp(pkt->csum, strcsum, GDB_CSUM_LEN);
}

void *
xrealloc(void *ptr, size_t size)
{
	void *r;

	if (!(r = realloc(ptr, size)))
		err(EXIT_FAILURE, "realloc failed");

	return r;
}

void *
xmalloc(size_t size)
{
	void *r;

	if (!(r = malloc(size)))
		err(EXIT_FAILURE, "malloc failed");

	return r;
}

void
gdb_free_packet(gdb_packet_t *pkt)
{
	if (pkt->data)
		free(pkt->data);
	free(pkt);
}
