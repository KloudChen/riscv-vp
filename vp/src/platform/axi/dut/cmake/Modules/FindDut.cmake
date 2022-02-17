set(DUT_DIR         //home/kloud/cosim/riscv-vp/vp/src/platform/axi/dut)
set(DUT_NAME        StringTransformer)
set(DUT_SRC_V       ${DUT_DIR}/${DUT_NAME}.v)
set(DUT_SC_DIR      ${DUT_DIR}/obj_dir) # generated systemc module dir
set(DUT_LIBRARIES   ${DUT_SC_DIR}/V${DUT_NAME}__ALL.a)
set(DUT_MF          V${DUT_NAME}.mk)    # makefile name of the generated module
