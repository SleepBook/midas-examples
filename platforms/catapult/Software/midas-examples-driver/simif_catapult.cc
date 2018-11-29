#include "simif_catapult.h"
#include <cassert>
#include <concurrent_queue.h>
#include <concrt.h>
#include <ppl.h>
#include <assert.h>
#include <stdio.h>


simif_catapult_t::simif_catapult_t() {
  //catapult_start();
  // Open handle to FPGA 
	printf("Opening handle...\n");
	FPGA_CreateHandle(&fpgaHandle, PCIE_HIP_NUM, 0x0, NULL, NULL);

	// Enable PCIe (default disabled)
	enablePCIe(fpgaHandle);
	DWORD reg = -1;
	FPGA_ReadShellRegister(fpgaHandle, 0, &reg);
	printf("Control register value: 0x%08x\n", reg);
}

simif_catapult_t::~simif_catapult_t() {
  //catapult_finish();
  // Close handle.
	FPGA_CloseHandle(fpgaHandle);
}

void simif_catapult_t::write(size_t addr, uint64_t data) {
  //catapult_softreg_write(addr, data);
	printf("write %lld to addr: %d\n", data, addr);
	FPGA_WriteSoftRegister(fpgaHandle, addr, data);
}

uint64_t simif_catapult_t::read(size_t addr) {
	uint64_t value;
	FPGA_ReadSoftRegister(fpgaHandle, addr, &value);
	printf("read %lld from addr: %d\n", value, addr);
	return value;
  //return catapult_softreg_read(addr);
}
