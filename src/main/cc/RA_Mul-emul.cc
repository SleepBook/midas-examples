#include "simif_emul.h"
#include "RA_Mul.h"

class RA_Mul_emul_t:
  public simif_emul_t,
  public RA_Mul_t { };

int main(int argc, char** argv) 
{
  RA_Mul_emul_t RA_Mul;
  RA_Mul.init(argc, argv, true);
  RA_Mul.run();
  return RA_Mul.finish();
}
