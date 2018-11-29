#ifndef __SIMIF_CATAPULT_H
#define __SIMIF_CATAPULT_H

#include "simif.h"    // from midas
//#include "catapult.h" // from catapult-protect
#ifdef COSIM
#include "../Common/FPGACoreLib_CoSim.h"
#else
#include "../../../Driver/Include/FPGACoreLib.h"
#pragma comment(lib, "../../../Driver/Bin/FPGACoreLib.lib")
#include "../../../Driver/Include/FPGAManagementLib.h"
#endif

typedef uint32_t PCIePayload;

typedef struct {
	bool eom;
	PCIePayload payload;
} PCIeSendPayload;


#define PCIE_HIP_NUM 0x0

#define MAX_BUF_SIZE_BYTES 65536
#define USE_INTERRUPT false

#define CONFIG_DRAM_CHAN0 600
#define CONFIG_DRAM_CHAN1 700
#define CONFIG_DRAM_INTERLEAVED 800

typedef enum {
	SINGLE_INORDER = 0,
	SINGLE_OOO = 1,
	PARALLEL = 2,
	PARALLEL_DECOUPLED = 3
} TestMode;

typedef enum {
	NORTH = 0,
	SOUTH = 1,
	EAST = 2,
	WEST = 3
} SL3Dir;

class simif_catapult_t: public virtual simif_t
{
  public:
    simif_catapult_t();
    virtual ~simif_catapult_t();
    virtual void write(size_t addr, uint64_t data);
    virtual uint64_t read(size_t addr);
  private:
    char in_buf[MMIO_WIDTH];
    char out_buf[MMIO_WIDTH];
	FPGA_HANDLE fpgaHandle;

	// Enable PCIe (default disabled)
	void enablePCIe(FPGA_HANDLE fpgaHandle) {
		DWORD pcie = -1;
		FPGA_ReadShellRegister(fpgaHandle, 0, &pcie);

		// set control_register[6]
		pcie = pcie | (1 << 6);
		FPGA_WriteShellRegister(fpgaHandle, 0, pcie);
	}
};

#endif // __SIMIF_CATAPULT_H
