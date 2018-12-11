//See LICENSE for license details.

#include "simif.h"

class RA_Mul_t: virtual simif_t
{
public:
  void run() {
    target_reset();
    uint32_t in_a, in_b;
    uint32_t prod;
      in_a = rand_next(2);
      in_b = rand_next(2);
    for (int i = 0 ; i < 1000 ; i++) {
      poke(io_B, in_b);
      poke(io_A, in_a);
      step(1);
      expect(io_P, in_a * in_b);
    } 
  }
};
