#include "simif.h"

class PointerChaser_t: virtual simif_t
{
public:
  PointerChaser_t(int argc, char** argv) {
    max_cycles = -1;
    latency = 16;
    address = 64;
    result = 1176;
    std::vector<std::string> args(argv + 1, argv + argc);
    for (auto &arg: args) {
      if (arg.find("+max-cycles=") == 0) {
        max_cycles = atoi(arg.c_str()+12);
      }
      if (arg.find("+latency=") == 0) {
        latency = atoi(arg.c_str()+9);
      }
      if (arg.find("+address=") == 0) {
        address = atoi(arg.c_str()+9);
      }
      if (arg.find("+result=") == 0) {
        result = atoi(arg.c_str()+9);
      }
    }
  }

  void run() {
#ifdef MEMMODEL_0_readLatency
    write(MEMMODEL_0_readMaxReqs, 8);
    write(MEMMODEL_0_writeMaxReqs, 8);
    write(MEMMODEL_0_readLatency, latency);
    write(MEMMODEL_0_writeLatency, latency);
#else
    write(MEMMODEL_0_LATENCY, latency);
#endif

    poke(io_startAddr_bits, address);
    poke(io_startAddr_valid, 1);
    do {
      step(1);
    } while (!peek(io_startAddr_ready));
    poke(io_startAddr_valid, 0);
    poke(io_result_ready, 1);
    do {
      step(1);
    } while (!peek(io_result_valid));
    expect(io_result_bits, result);
  }
private:
  uint64_t max_cycles;
  uint64_t address;
  biguint_t result; // 64 bit
  size_t latency;
};