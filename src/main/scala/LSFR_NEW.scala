//See LICENSE for license details.

package midas
package examples

import chisel3._

class LSFR_NEW extends Module {
  val io = IO(new Bundle {
    val out = Output(UInt(32.W))
  })
  //14 is a magic number
  val data = RegInit(14.U(32.W))
  data := ((data << 1) | (data(5) ^ data(8)))
  io.out := data
}
