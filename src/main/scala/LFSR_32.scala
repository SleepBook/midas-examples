//See LICENSE for license details.

package midas
package examples

import chisel3._

class LFSR_32 extends Module {
  val io = IO(new Bundle {
    //hard code as 32 bits
    val out = Output(Vec(32, UInt(1.W)))
  })
  val feedback = Wire(UInt(1.W))
  //val r0 = Reg(UInt(1.W))
  val lfsrRegChain = Reg(Vec(32, UInt(1.W)))
  for (i <- (0 until 32).reverse) {
    if (i == 0)
      lfsrRegChain(i) := feedback
    else
      lfsrRegChain(i) := lfsrRegChain(i-1)
  }
  io.out <> lfsrRegChain
  feedback := lfsrRegChain(31) ^ lfsrRegChain(4)

}
