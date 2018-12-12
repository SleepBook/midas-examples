#ifndef __SHIFTREGISTER_H
#define __SHIFTREGISTER_H
static const char* const TARGET_NAME = "ShiftRegister";
#define PLATFORM_TYPE VCatapultShim
#define ENABLE_SNAPSHOT 
#define KEEP_SAMPLES_IN_MEM 
#define data_t uint64_t

// Widget: Master
#define MASTER(x) MASTER_ ## x
#define MASTER_SIM_RESET 16
#define MASTER_STEP 17
#define MASTER_DONE 18
#define CHANNEL_SIZE 3
// Pokeable target inputs
#define POKE_SIZE 2L
const static unsigned int reset = 0;
const static unsigned int io_in = 1;
static unsigned int INPUT_ADDRS[2] = {
	20,
	21
};
static const char* const INPUT_NAMES[2] = {
	"reset",
	"io_in"
};
static unsigned int INPUT_CHUNKS[2] = {
	1,
	1
};
// Peekable target outputs
#define PEEK_SIZE 1L
const static unsigned int io_out = 0;
static unsigned int OUTPUT_ADDRS[1] = {
	22
};
static const char* const OUTPUT_NAMES[1] = {
	"io_out"
};
static unsigned int OUTPUT_CHUNKS[1] = {
	1
};

// Widget: DaisyChainController
#define DAISYCHAINCONTROLLER(x) DAISYCHAINCONTROLLER_ ## x
#define DAISY_WIDTH 64
#define SRAM_RESTART_ADDR 0
#define REGFILE_RESTART_ADDR 1
enum CHAIN_TYPE { TRACE_CHAIN, REGS_CHAIN, SRAM_CHAIN, REGFILE_CHAIN, CNTR_CHAIN, CHAIN_NUM };
static unsigned int CHAIN_SIZE[5] = {
	1,
	1,
	1,
	1,
	1
};
static unsigned int CHAIN_ADDR[5] = {
	3,
	5,
	7,
	9,
	11
};
// Wire Input Traces
#define IN_TR_SIZE 2
static unsigned int IN_TR_ADDRS[2] = {
	24,
	25
};
static const char* const IN_TR_NAMES[2] = {
	"reset",
	"io_in"
};
static unsigned int IN_TR_CHUNKS[2] = {
	1,
	1
};
// Wire Output Traces
#define OUT_TR_SIZE 1
static unsigned int OUT_TR_ADDRS[1] = {
	26
};
static const char* const OUT_TR_NAMES[1] = {
	"io_out"
};
static unsigned int OUT_TR_CHUNKS[1] = {
	1
};
// ReadyValidIO Input Traces
#define IN_TR_READY_VALID_SIZE 0
static const void* const IN_TR_READY_VALID_NAMES[1] = {

};
static const void* const IN_TR_VALID_ADDRS[1] = {

};
static const void* const IN_TR_READY_ADDRS[1] = {

};
static const void* const IN_TR_BITS_ADDRS[1] = {

};
static const void* const IN_TR_BITS_CHUNKS[1] = {

};
static const void* const IN_TR_BITS_FIELD_NUMS[1] = {

};
static const void* const IN_TR_BITS_FIELD_WIDTHS[1] = {

};
static const void* const IN_TR_BITS_FIELD_NAMES[1] = {

};
// ReadyValidIO Output Traces
#define OUT_TR_READY_VALID_SIZE 0
static const void* const OUT_TR_READY_VALID_NAMES[1] = {

};
static const void* const OUT_TR_VALID_ADDRS[1] = {

};
static const void* const OUT_TR_READY_ADDRS[1] = {

};
static const void* const OUT_TR_BITS_ADDRS[1] = {

};
static const void* const OUT_TR_BITS_CHUNKS[1] = {

};
static const void* const OUT_TR_BITS_FIELD_NUMS[1] = {

};
static const void* const OUT_TR_BITS_FIELD_WIDTHS[1] = {

};
static const void* const OUT_TR_BITS_FIELD_NAMES[1] = {

};
#define TRACELEN_ADDR 27
#define TRACE_MAX_LEN 1024

// Widget: LOADMEM
#define LOADMEM(x) LOADMEM_ ## x
#define LOADMEM_W_ADDRESS 28
#define LOADMEM_W_DATA 29
#define LOADMEM_R_ADDRESS 30
#define LOADMEM_R_DATA 31
#define MEM_DATA_CHUNK 1L

// Simulation Constants
#define PCIE_WIDTH 640
#define SOFTREG_ADDR_WIDTH 32
#define SOFTREG_DATA_WIDTH 64
#define SERIAL_WIDTH 80
#define UMI_ADDR_WIDTH 64
#define UMI_DATA_WIDTH 576
#define MMIO_WIDTH 8
#define MEM_WIDTH 64
#define CTRL_ID_BITS 12
#define CTRL_ADDR_BITS 32
#define CTRL_DATA_BITS 64
#define CTRL_STRB_BITS 8
#define MEM_ADDR_BITS 32
#define MEM_DATA_BITS 64
#define MEM_ID_BITS 6
#define MEM_SIZE_BITS 3
#define MEM_LEN_BITS 8
#define MEM_RESP_BITS 2
#define MEM_STRB_BITS 8
#endif  // __SHIFTREGISTER_H