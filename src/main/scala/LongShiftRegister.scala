//See LICENSE for license details.

package midas
package examples

import chisel3._

class LongShiftRegister extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(1.W))
    val out = Output(UInt(1.W))
  })
  val r0 = RegNext(io.in)
  val r1 = RegNext(r0)
  val r2 = RegNext(r1)
  val r3 = RegNext(r2)
  val r4 = RegNext(r3)
  val r5 = RegNext(r4)
  val r6 = RegNext(r5)
  val r7 = RegNext(r6)
  val r8 = RegNext(r7)
  val r9 = RegNext(r8)
  val r10 = RegNext(r9)
  val r11 = RegNext(r10)
  val r12 = RegNext(r11)
  val r13 = RegNext(r12)
  val r14 = RegNext(r13)
  val r15 = RegNext(r14)
  val r16 = RegNext(r15)
  val r17 = RegNext(r16)
  val r18 = RegNext(r17)
  val r19 = RegNext(r18)
  val r20 = RegNext(r19)
  val r21 = RegNext(r20)
  val r22 = RegNext(r21)
  val r23 = RegNext(r22)
  val r24 = RegNext(r23)
  val r25 = RegNext(r24)
  val r26 = RegNext(r25)
  val r27 = RegNext(r26)
  val r28 = RegNext(r27)
  val r29 = RegNext(r28)
  val r30 = RegNext(r29)
  val r31 = RegNext(r30)
  val r32 = RegNext(r31)
  val r33 = RegNext(r32)

  io.out := r33
}
