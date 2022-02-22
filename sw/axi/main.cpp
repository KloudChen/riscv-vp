/**
 * @file main.cpp
 * @author cw (wei.c.chen@intel.com)
 * @brief A RISC-V program to test the functionality of the AXI-interfaced 
 * accelerator.
 * @version 0.1
 * @date 2022-02-18
 * 
 * Copyright (C) 2020, Intel Corporation. All rights reserved.
 * 
 */

#include <assert.h>
#include <stdint.h>
#include <iostream>
#include <vector>
#include <string.h>

using namespace std;

enum TransFunc {
    TO_LOWER = 0,
    TO_UPPER
};

vector<const char *> FuncStrings = {"TO LOWER", "TO UPPER"};

extern "C" {
    void transform(const char *src, 
        const char* dst, 
        size_t len,
        uint32_t func);
}

bool do_test(const char* src,
        const char* dst,
        const char* expect,
        size_t len,
        TransFunc func = TO_LOWER) {
    cout << "Test " << FuncStrings[func] << endl;
    transform(src, dst, len, func);
    cout << "Input: " << src << endl;
    cout << "Expect: " << expect << endl;
    cout << "Got: " << dst << endl;
    if (memcmp(dst, expect, len) == 0) {
        cout << "Test " << FuncStrings[func] << " Success!!" << endl;
        return true;   
    }
    else {
        cout << "Test " << FuncStrings[func] << " Error!!" << endl;
        return false;
    }
}

int main(int argc, char* argv[]) {
    char test_data[] = "Hello from Risc-V acceleratoR!";
    char lower_data[] = "hello from risc-v accelerator!";
    char upper_data[] = "HELLO FROM RISC-V ACCELERATOR!";
    char result_buffer[256];
    
    do_test(test_data, result_buffer, lower_data, sizeof(test_data), TO_LOWER);
    memset(result_buffer, 0, sizeof(result_buffer));
    do_test(test_data, result_buffer, upper_data, sizeof(test_data), TO_UPPER);
    return 0;
}