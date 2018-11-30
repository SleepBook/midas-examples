//See LICENSE for license details.

#include "simif_catapult.h"
#include "ShiftRegister.h"

class ShiftRegister_catapult_t:
  public ShiftRegister_t,
  public simif_catapult_t { };

int main(int argc, char** argv) 
{
  ShiftRegister_catapult_t ShiftRegister;
  ShiftRegister.init(argc, argv, true);
  ShiftRegister.run();
  return ShiftRegister.finish();
}
