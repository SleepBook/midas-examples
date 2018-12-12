//See LICENSE for license details.

#include "simif.h"

class ShiftRegister_t: virtual simif_t
{
public:
  void run() {
    std::vector<uint32_t> reg(4);
	// Write 0 to input channel "reset" (addr 20)
	// Do handshake once
		// Write 1 to channel MASTER_STEP (addr 17). 
		// Wait until 1 can be read out from MASTER_DONE (addr 18).
	// Write 1 to input channel "reset"
	// Do handshake 5 times
	// Write 0 to input channel "reset"
    target_reset();
    for (int i = 0 ; i < 64 ; i++) {
      uint32_t in = rand_next(2);
	  // Write to input channel "io_in" (addr 21)
	  poke(io_in, in);
	  // Do handshake once
	  // Increment timestamp
	  step(1, true, true);
	  // After the 4th iteration,
	  // Check if the value read from output channel "io_out" (addr 22) equals to reg[3]
	  if (cycles() > 4) expect(io_out, reg[3]);
	  // Shift the reference register value
	  if (i == 31) {
		  for (int j = 0; j < 4; j++) reg[j] = 1;
	  }
	  else {
		  for (int j = 3; j > 0; j--) reg[j] = reg[j - 1];
		  reg[0] = in;
	  }
    } 
  }
};
