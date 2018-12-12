package midas
package examples


import chisel3._
import chisel3.util._
class HA extends Module {
  val io = IO(new Bundle {
    val s = Output(Bool())
    val cout = Output(Bool())
    val a = Input(Bool())
    val b = Input(Bool())
  })
  io.cout := io.a & io.b
  io.s := io.a ^ io.b

}

object HA {
  def apply(a: Bool, b: Bool, s: Bool, cout : Bool) = {
    val tmp = Module(new HA)
    tmp.io.a := a
    tmp.io.b := b
    s := tmp.io.s
    cout := tmp.io.cout
  }
}

class FA extends Module {
  val io = IO(new Bundle {
    val s = Output(Bool())
    val cout = Output(Bool())
    val a = Input(Bool())
    val b = Input(Bool())
    val cin = Input(Bool())
  })

  io.s := io.a ^ io.b ^ io.cin
  io.cout := (io.a & io.b) | (io.a & io.cin) | (io.b & io.cin)

}

object FA {
  def apply(a: Bool, b: Bool, cin: Bool, s: Bool, cout : Bool) = {
    val tmp = Module(new FA)
    tmp.io.a := a
    tmp.io.b := b
    tmp.io.cin := cin
    s := tmp.io.s
    cout := tmp.io.cout
  }
}

class BoothEncoder_radix4 (WIDTH : Int)
  extends Module {
  val io = IO(new Bundle {
    val eB = Output(Vec(WIDTH/2, UInt(3.W)))
    val B = Input(UInt(WIDTH.W))
  })
  //val B_ext = VecInit(io.B.toBools :+ 0.U(1.W).toBool).
  val B_ext = Cat(io.B, 0.U(1.W))
  println(B_ext)

  for (i <- 0 until 8) {
     //val eB_cur = Wire(Vec(3, Bool()))
     //eB_cur(0) := B_ext(i+1) ^ B_ext(i)
     //eB_cur(1) := (B_ext(i + 2) & (~B_ext(i + 1)) & (~B_ext(i))) | ((~B_ext(i + 2)) & B_ext(i + 1) & B_ext(i))
     //eB_cur(2) := B_ext(i + 2)
     //io.eB(i) := eB_cur.asUInt
    //io.eB(i) := Cat(Seq(B_ext(2*i+2), B_ext(2*i+1), B_ext(2*i))).asUInt
    io.eB(i) :=Cat(Seq(B_ext(2 * i + 2) & ~(B_ext(2 * i + 1) & B_ext(2 * i)),
      (B_ext(2 * i + 2) & (~B_ext(2 * i + 1)) & (~B_ext(2 * i))) | ((~B_ext(2 * i + 2)) & B_ext(2 * i + 1) & B_ext(2 * i)),
      B_ext(2 * i + 1) ^ B_ext(2 * i))).asUInt
    //io.eB(i) := (B_ext(2*i + 2) << 2) | (((B_ext(2*i + 2) & (~B_ext(2*i + 1)) & (~B_ext(2*i))) | ((~B_ext(2*i + 2)) & B_ext(2*i + 1) & B_ext(2*i))) << 1) | (B_ext(2*i+1) ^ B_ext(2*i))
    /*switch(B_ext(2*i+2,2*i)){
      is("b000".U){
        io.eB(i) := 0.U
      }
      is("b001".U){
        io.eB(i) := 1.U
      }
      is("b010".U){
        io.eB(i) := 1.U
      }
      is("b011".U){
        io.eB(i) := 2.U
      }
      is("b100".U){
        io.eB(i) := 6.U
      }
      is("b101".U){
        io.eB(i) := 5.U
      }
      is("b110".U){
        io.eB(i) := 5.U
      }
      is("b111".U){
        io.eB(i) := 0.U
      }
    }*/
  }

}

object BoothEncoder_radix4{
  def apply(B: UInt, eB :Seq[UInt], WIDTH: Int) = {
    val tmp = Module(new BoothEncoder_radix4(WIDTH))
    tmp.io.B := B
    tmp.io.eB <> eB
  }
}

class PPGen(WIDTH:Int) extends Module{
  val io = IO(new Bundle {
    val PP = Output(Vec(WIDTH/2, UInt(WIDTH.W)))
    val SS = Output(UInt(WIDTH.W))
    val SC = Output(UInt((WIDTH/2).W))
    val S = Output(UInt((WIDTH/2).W))
    val eB = Input(Vec(WIDTH/2, UInt(3.W)))
    val A = Input(UInt(WIDTH.W))
  })

  io.SS := "b1010101010101011".U
  val S_v = Wire(Vec(WIDTH/2, Bool()))
  val SC_v = Wire(Vec(WIDTH/2, Bool()))
  for (i <- 0 until 8){
    when(io.eB(i) === 0.U(3.W) || io.eB(i) === 4.U(3.W)) {
      io.PP(i) := 0.U
    }.elsewhen(io.eB(i) === 1.U(3.W)) {
      io.PP(i) := io.A
    }.elsewhen(io.eB(i) === 2.U(3.W)) {
      io.PP(i) := (io.A << 1)(WIDTH - 1, 0)
    }.elsewhen(io.eB(i) === 5.U(3.W)) {
      io.PP(i) := ~io.A
    }.elsewhen(io.eB(i) === 6.U(3.W)){
      io.PP(i) := ~((io.A << 1)(WIDTH -1, 0))
    }.otherwise{
      io.PP(i) := 0.U
    }

    S_v(i) := io.eB(i)(2)
    //SC_v(i) := ~(io.eB(i)(2) ^ io.A(WIDTH-1))
    //SC_v(i) := ~((io.eB(i)(2) | ((~io.eB(i)(1)) & (~io.eB(i)(0)))) ^ io.A(WIDTH-1))
    when(io.eB(i)(2) === true.B && io.A =/= 0.U &&  io.A(WIDTH-1) === 0.U){
      SC_v(i) := 0.U
    }.elsewhen(io.eB(i)(2) === 0.U && (io.eB(i)(1)|io.eB(i)(0)) === 1.U && io.A(WIDTH-1) === 1.U){
      SC_v(i) := 0.U
    }.otherwise{
      SC_v(i) := 1.U
    }
  }
  io.S := S_v.asUInt()
  io.SC := SC_v.asUInt()
  //io.S := Cat(Range(7, -1, -1) map (x =>S_v(x))).asUInt
  //io.SC := Cat(Range(7, -1, -1) map (x =>SC_v(x))).asUInt

}

object PPGen {
  def apply(A: UInt, eB : Seq[UInt], PP : Seq[UInt], SS: UInt, SC: UInt, S: UInt, WIDTH: Int) = {
    val tmp = Module(new PPGen(WIDTH))
    tmp.io.A := A
    tmp.io.eB := eB
    tmp.io.PP <> PP
    SS := tmp.io.SS
    SC := tmp.io.SC
    S := tmp.io.S
  }
}

class Reduction_1 (WIDTH:Int, HEIGHT:Int) extends Module {
  val io = IO(new Bundle {
    val matrix = Output(Vec(HEIGHT, Vec(WIDTH * 2, Bool())))
    val PP = Input(Vec(WIDTH/2, UInt(WIDTH.W)))
    val SS = Input(UInt(WIDTH.W))
    val SC = Input(UInt((WIDTH/2).W))
    val S = Input(UInt((WIDTH/2).W))
  })
  def set_zero(m : Seq[Seq[Bool]], col:Int, row_start:Int, row_end:Int)={
    for (row <- row_start until row_end){
      m(row)(col) := false.B
    }
  }
  //col 0
  HA(io.PP(0)(0), io.S(0), io.matrix(0)(0), io.matrix(1)(1))
  set_zero(io.matrix, 0, 1, HEIGHT)
  //col 1
  io.matrix(0)(1) := io.PP(0)(1)
  set_zero(io.matrix, 1, 2, HEIGHT)/*row_start=1 is wrong, fixed to 2*/
  //col 2
  FA(io.PP(0)(2), io.PP(1)(0), io.S(1), io.matrix(0)(2), io.matrix(1)(3))
  set_zero(io.matrix, 2, 1, HEIGHT)
  //col 3
  io.matrix(0)(3) := io.PP(0)(3)
  io.matrix(2)(3) := io.PP(1)(1)
  set_zero(io.matrix, 3, 3, HEIGHT)
  //col 4
  FA(io.PP(0)(4), io.PP(1)(2), io.PP(2)(0), io.matrix(0)(4), io.matrix(1)(5))
  io.matrix(1)(4) := io.S(2)
  set_zero(io.matrix, 4, 2, HEIGHT)
  //col 5
  FA(io.PP(0)(5), io.PP(1)(3), io.PP(2)(1), io.matrix(0)(5), io.matrix(1)(6))
  set_zero(io.matrix, 5, 2, HEIGHT)
  //col 6
  FA(io.PP(0)(6), io.PP(1)(4), io.PP(2)(2), io.matrix(0)(6), io.matrix(1)(7))
  io.matrix(2)(6) := io.PP(3)(0)
  io.matrix(3)(6) := io.S(3)
  set_zero(io.matrix, 6, 4, HEIGHT)
  //col 7
  FA(io.PP(0)(7), io.PP(1)(5), io.PP(2)(3), io.matrix(0)(7), io.matrix(1)(8))
  io.matrix(2)(7) := io.PP(3)(1)
  set_zero(io.matrix, 7, 3, HEIGHT)
  //col 8
  FA(io.PP(0)(8), io.PP(1)(6), io.PP(2)(4), io.matrix(0)(8), io.matrix(1)(9))
  FA(io.PP(3)(2), io.PP(4)(0), io.S(4), io.matrix(2)(8), io.matrix(3)(9))
  set_zero(io.matrix, 8, 3, HEIGHT)
  //col 9
  FA(io.PP(0)(9), io.PP(1)(7), io.PP(2)(5), io.matrix(0)(9), io.matrix(1)(10))
  io.matrix(2)(9) := io.PP(3)(3)
  io.matrix(4)(9) := io.PP(4)(1)
  set_zero(io.matrix, 9, 5, HEIGHT)
  //col 10
  FA(io.PP(0)(10), io.PP(1)(8), io.PP(2)(6), io.matrix(0)(10), io.matrix(1)(11))
  FA(io.PP(3)(4), io.PP(4)(2), io.PP(5)(0), io.matrix(2)(10), io.matrix(3)(11))
  io.matrix(3)(10) := io.S(5)
  set_zero(io.matrix, 10, 4, HEIGHT)
  //col 11
  FA(io.PP(0)(11), io.PP(1)(9), io.PP(2)(7), io.matrix(0)(11), io.matrix(1)(12))
  FA(io.PP(3)(5), io.PP(4)(3), io.PP(5)(1), io.matrix(2)(11), io.matrix(3)(12))
  set_zero(io.matrix,11, 4,HEIGHT)
  //col 12
  FA(io.PP(0)(12), io.PP(1)(10), io.PP(2)(8), io.matrix(0)(12), io.matrix(1)(13))
  FA(io.PP(3)(6), io.PP(4)(4), io.PP(5)(2), io.matrix(2)(12), io.matrix(3)(13))
  io.matrix(4)(12) := io.PP(6)(0)
  io.matrix(5)(12) := io.S(6)

  //col 13
  FA(io.PP(0)(13), io.PP(1)(11), io.PP(2)(9), io.matrix(0)(13), io.matrix(1)(14))
  FA(io.PP(3)(7), io.PP(4)(5), io.PP(5)(3), io.matrix(2)(13), io.matrix(3)(14))
  io.matrix(4)(13) := io.PP(6)(1)
  set_zero(io.matrix, 13, 5, HEIGHT)
  //col 14
  FA(io.PP(0)(14), io.PP(1)(12), io.PP(2)(10), io.matrix(0)(14), io.matrix(1)(15))
  FA(io.PP(3)(8), io.PP(4)(6), io.PP(5)(4), io.matrix(2)(14), io.matrix(3)(15))
  FA(io.PP(6)(2), io.PP(7)(0), io.S(7), io.matrix(4)(14), io.matrix(5)(15))
  set_zero(io.matrix, 14, 5, HEIGHT)
  //col 15
  FA(io.PP(0)(15), io.PP(1)(13), io.PP(2)(11), io.matrix(0)(15), io.matrix(1)(16))
  FA(io.PP(3)(9), io.PP(4)(7), io.PP(5)(5), io.matrix(2)(15), io.matrix(3)(16))
  //io.matrix(4)(15) := io.PP(6)(3)
  //io.matrix(6)(15) := io.PP(7)(1)
  HA(io.PP(6)(3), io.PP(7)(1), io.matrix(4)(15), io.matrix(5)(16))//dadda height limit

  //col 16
  FA(io.SC(0), io.PP(1)(14), io.PP(2)(12), io.matrix(0)(16), io.matrix(1)(17))
  FA(io.PP(3)(10), io.PP(4)(8), io.PP(5)(6), io.matrix(2)(16), io.matrix(3)(17))
  FA(io.PP(6)(4), io.PP(7)(2), io.SS(0), io.matrix(4)(16), io.matrix(5)(17))
  //col 17
  FA(io.PP(1)(15), io.PP(2)(13), io.PP(3)(11), io.matrix(0)(17), io.matrix(1)(18))
  FA(io.PP(4)(9), io.PP(5)(7), io.PP(6)(5), io.matrix(2)(17), io.matrix(3)(18))
  HA(io.PP(7)(3), io.SS(1), io.matrix(4)(17), io.matrix(5)(18))
  //col 18
  FA(io.SC(1), io.PP(2)(14), io.PP(3)(12), io.matrix(0)(18), io.matrix(1)(19))
  FA(io.PP(4)(10), io.PP(5)(8), io.PP(6)(6), io.matrix(2)(18), io.matrix(3)(19))
  HA(io.PP(7)(4), io.SS(2), io.matrix(4)(18), io.matrix(5)(19))
  //col 19
  FA(io.PP(2)(15), io.PP(3)(13), io.PP(4)(11), io.matrix(0)(19), io.matrix(1)(20))
  FA(io.PP(5)(9), io.PP(6)(7), io.PP(7)(5), io.matrix(2)(19), io.matrix(3)(20))
  io.matrix(4)(19) := io.SS(3)
  //col 20
  FA(io.SC(2), io.PP(3)(14), io.PP(4)(12), io.matrix(0)(20), io.matrix(1)(21))
  FA(io.PP(5)(10), io.PP(6)(8), io.PP(7)(6), io.matrix(2)(20), io.matrix(3)(21))
  io.matrix(4)(20) := io.SS(4)
  set_zero(io.matrix, 20, 5, HEIGHT)
  //col 21
  FA(io.PP(3)(15), io.PP(4)(13), io.PP(5)(11), io.matrix(0)(21), io.matrix(1)(22))
  FA(io.PP(6)(9), io.PP(7)(7), io.SS(5), io.matrix(2)(21), io.matrix(3)(22))
  set_zero(io.matrix, 21, 4, HEIGHT)
  //col 22
  FA(io.SC(3), io.PP(4)(14), io.PP(5)(12), io.matrix(0)(22), io.matrix(1)(23))
  FA(io.PP(6)(10), io.PP(7)(8), io.SS(6), io.matrix(2)(22), io.matrix(3)(23))
  set_zero(io.matrix, 22, 4, HEIGHT)
  //col 23
  FA(io.PP(4)(15), io.PP(5)(13), io.PP(6)(11), io.matrix(0)(23), io.matrix(1)(24))
  io.matrix(2)(23) := io.PP(7)(9)
  io.matrix(4)(23) := io.SS(7)
  set_zero(io.matrix, 23, 5, HEIGHT)
  //col 24
  FA(io.SC(4), io.PP(5)(14), io.PP(6)(12), io.matrix(0)(24), io.matrix(1)(25))
  io.matrix(2)(24) := io.PP(7)(10)
  io.matrix(3)(24) := io.SS(8)
  set_zero(io.matrix,24,4, HEIGHT)
  //col 25
  FA(io.PP(5)(15), io.PP(6)(13), io.PP(7)(11), io.matrix(0)(25), io.matrix(1)(26))
  io.matrix(2)(25) := io.SS(9)
  set_zero(io.matrix, 25, 3, HEIGHT)
  //col 26
  FA(io.SC(5), io.PP(6)(14), io.PP(7)(12), io.matrix(0)(26), io.matrix(1)(27))
  io.matrix(2)(26) := io.SS(10)
  set_zero(io.matrix, 26, 3, HEIGHT)
  //col 27
  FA(io.PP(6)(15), io.PP(7)(13), io.SS(11), io.matrix(0)(27), io.matrix(1)(28))
  set_zero(io.matrix, 27, 2, HEIGHT)
  //col 28
  FA(io.SC(6), io.PP(7)(14), io.SS(12), io.matrix(0)(28), io.matrix(1)(29))
  set_zero(io.matrix, 28, 2, HEIGHT)
  //col 29
  io.matrix(0)(29) := io.PP(7)(15)
  io.matrix(2)(29) := io.SS(13)
  set_zero(io.matrix, 29, 3, HEIGHT)
  //col 30
  io.matrix(0)(30) := io.SC(7)
  io.matrix(1)(30) := io.SS(14)
  set_zero(io.matrix, 30, 2, HEIGHT)
  //col 31
  io.matrix(0)(31) := io.SS(15)
  set_zero(io.matrix, 31, 1, HEIGHT)
}

object Reduction_1{
  def apply(PP: Seq[UInt], SS: UInt, SC: UInt, S: UInt, matrix: Seq[Seq[Bool]], WIDTH: Int, HEIGHT: Int) = {
    val tmp = Module(new Reduction_1(WIDTH, HEIGHT))
    tmp.io.PP <> PP
    tmp.io.SS := SS
    tmp.io.SC := SC
    tmp.io.S := S
    for((a, b) <- tmp.io.matrix zip matrix)
      a <> b
  }
}

class Reduction_2 (WIDTH: Int, HEIGHT_i: Int, HEIGHT_o: Int) extends Module{
  val io = IO(new Bundle {
    val matrix_o = Output(Vec(HEIGHT_o, Vec(WIDTH * 2, Bool())))
    val matrix_i = Input(Vec(HEIGHT_i, Vec(WIDTH * 2, Bool())))
  })
  def set_zero(m : Seq[Seq[Bool]], col:Int, row_start:Int, row_end:Int)={
    for (row <- row_start until row_end){
      m(row)(col) := false.B
    }
  }
  //col 0
  io.matrix_o(0)(0) := io.matrix_i(0)(0)
  set_zero(io.matrix_o, 0, 1, HEIGHT_o)
  //col 1
  HA(io.matrix_i(0)(1), io.matrix_i(1)(1), io.matrix_o(0)(1), io.matrix_o(1)(2))
  set_zero(io.matrix_o, 1, 1, HEIGHT_o)
  //col 2
  io.matrix_o(0)(2) := io.matrix_i(0)(2)
  set_zero(io.matrix_o, 2, 2, HEIGHT_o)/*row start should be 2, not 1, fixed*/
  //col 3
  FA(io.matrix_i(0)(3),io.matrix_i(1)(3),io.matrix_i(2)(3), io.matrix_o(0)(3), io.matrix_o(1)(4))
  set_zero(io.matrix_o, 3, 1, HEIGHT_o)
  //col 4
  io.matrix_o(0)(4) := io.matrix_i(0)(4)
  io.matrix_o(2)(4) := io.matrix_i(1)(4) /*fixed, should put to 2,4, not 1,4*/
  set_zero(io.matrix_o, 4, 3, HEIGHT_o)/*fixed, row_start should be 3, not 2*/
  //col 5
  io.matrix_o(0)(5) := io.matrix_i(0)(5)
  io.matrix_o(1)(5) := io.matrix_i(1)(5)
  set_zero(io.matrix_o, 5, 2, HEIGHT_o)
  //col 6
  FA(io.matrix_i(0)(6),io.matrix_i(1)(6),io.matrix_i(2)(6), io.matrix_o(0)(6), io.matrix_o(1)(7))
  io.matrix_o(1)(6) := io.matrix_i(3)(6)
  set_zero(io.matrix_o, 6, 2, HEIGHT_o)
  //col 7
  FA(io.matrix_i(0)(7),io.matrix_i(1)(7),io.matrix_i(2)(7), io.matrix_o(0)(7), io.matrix_o(1)(8))
  set_zero(io.matrix_o, 7, 2, HEIGHT_o)
  //col 8
  FA(io.matrix_i(0)(8),io.matrix_i(1)(8),io.matrix_i(2)(8), io.matrix_o(0)(8), io.matrix_o(1)(9))
  set_zero(io.matrix_o, 8, 2, HEIGHT_o)
  //col 9
  FA(io.matrix_i(0)(9),io.matrix_i(1)(9),io.matrix_i(2)(9), io.matrix_o(0)(9), io.matrix_o(1)(10))
  io.matrix_o(2)(9) := io.matrix_i(3)(9)
  io.matrix_o(3)(9) := io.matrix_i(4)(9)
  //col 10
  FA(io.matrix_i(0)(10),io.matrix_i(1)(10),io.matrix_i(2)(10), io.matrix_o(0)(10), io.matrix_o(1)(11))
  io.matrix_o(2)(10) := io.matrix_i(3)(10)
  set_zero(io.matrix_o, 10, 3, HEIGHT_o)
  //col 11
  FA(io.matrix_i(0)(11),io.matrix_i(1)(11),io.matrix_i(2)(11), io.matrix_o(0)(11), io.matrix_o(1)(12))
  io.matrix_o(2)(11) := io.matrix_i(3)(11)
  set_zero(io.matrix_o, 11, 3, HEIGHT_o)
  //col 12
  FA(io.matrix_i(0)(12),io.matrix_i(1)(12),io.matrix_i(2)(12), io.matrix_o(0)(12), io.matrix_o(1)(13))
  FA(io.matrix_i(3)(12),io.matrix_i(4)(12),io.matrix_i(5)(12), io.matrix_o(2)(12), io.matrix_o(3)(13))
  set_zero(io.matrix_o, 12, 3, HEIGHT_o)
  //col 13
  FA(io.matrix_i(0)(13),io.matrix_i(1)(13),io.matrix_i(2)(13), io.matrix_o(0)(13), io.matrix_o(1)(14))
  HA(io.matrix_i(3)(13), io.matrix_i(4)(13), io.matrix_o(2)(13), io.matrix_o(3)(14))
  //col 14
  FA(io.matrix_i(0)(14),io.matrix_i(1)(14),io.matrix_i(2)(14), io.matrix_o(0)(14), io.matrix_o(1)(15))
  HA(io.matrix_i(3)(14), io.matrix_i(4)(14), io.matrix_o(2)(14), io.matrix_o(3)(15))
  //col 15 - 19
  for (j <- 15 to 19) {
    FA(io.matrix_i(0)(j), io.matrix_i(1)(j), io.matrix_i(2)(j), io.matrix_o(0)(j), io.matrix_o(1)(j+1))
    FA(io.matrix_i(3)(j), io.matrix_i(4)(j), io.matrix_i(5)(j), io.matrix_o(2)(j), io.matrix_o(3)(j+1))
  }
  //col 20
  FA(io.matrix_i(0)(20),io.matrix_i(1)(20),io.matrix_i(2)(20), io.matrix_o(0)(20), io.matrix_o(1)(21))
  HA(io.matrix_i(3)(20), io.matrix_i(4)(20), io.matrix_o(2)(20), io.matrix_o(3)(21))
  //col 21
  FA(io.matrix_i(0)(21),io.matrix_i(1)(21),io.matrix_i(2)(21), io.matrix_o(0)(21), io.matrix_o(1)(22))
  io.matrix_o(2)(21) := io.matrix_i(3)(21)
  //col 22
  FA(io.matrix_i(0)(22),io.matrix_i(1)(22),io.matrix_i(2)(22), io.matrix_o(0)(22), io.matrix_o(1)(23))
  io.matrix_o(2)(22) := io.matrix_i(3)(22)
  set_zero(io.matrix_o, 22, 3, HEIGHT_o)
  //col 23
  FA(io.matrix_i(0)(23),io.matrix_i(1)(23),io.matrix_i(2)(23), io.matrix_o(0)(23), io.matrix_o(1)(24))
  io.matrix_o(2)(23) := io.matrix_i(3)(23)
  io.matrix_o(3)(23) := io.matrix_i(4)(23)
  //col 24
  FA(io.matrix_i(0)(24),io.matrix_i(1)(24),io.matrix_i(2)(24), io.matrix_o(0)(24), io.matrix_o(1)(25))
  io.matrix_o(2)(24) := io.matrix_i(3)(24)
  set_zero(io.matrix_o, 24, 3, HEIGHT_o)
  //col 25
  FA(io.matrix_i(0)(25),io.matrix_i(1)(25),io.matrix_i(2)(25), io.matrix_o(0)(25), io.matrix_o(1)(26))
  set_zero(io.matrix_o, 25, 2, HEIGHT_o)
  //col 26
  FA(io.matrix_i(0)(26),io.matrix_i(1)(26),io.matrix_i(2)(26), io.matrix_o(0)(26), io.matrix_o(1)(27))
  set_zero(io.matrix_o, 26, 2, HEIGHT_o)
  //col 27
  io.matrix_o(0)(27) := io.matrix_i(0)(27)
  io.matrix_o(2)(27) := io.matrix_i(1)(27)
  set_zero(io.matrix_o, 27, 3, HEIGHT_o)
  //col 28
  io.matrix_o(0)(28) := io.matrix_i(0)(28)
  io.matrix_o(1)(28) := io.matrix_i(1)(28)
  set_zero(io.matrix_o, 28, 2, HEIGHT_o)
  //col 29
  FA(io.matrix_i(0)(29),io.matrix_i(1)(29),io.matrix_i(2)(29), io.matrix_o(0)(29), io.matrix_o(1)(30))
  set_zero(io.matrix_o, 29, 1, HEIGHT_o)
  //col 30
  io.matrix_o(0)(30) := io.matrix_i(0)(30)
  io.matrix_o(2)(30) := io.matrix_i(1)(30)
  set_zero(io.matrix_o, 30, 3, HEIGHT_o)
  //col 31
  io.matrix_o(0)(31) := io.matrix_i(0)(31)
  set_zero(io.matrix_o, 31, 1, HEIGHT_o)

}

object Reduction_2{
  def apply(matrix_i : Seq[Seq[Bool]], matrix_o: Seq[Seq[Bool]], WIDTH: Int, HEIGHT_i: Int, HEIGHT_o : Int) = {
    val tmp = Module(new Reduction_2(WIDTH, HEIGHT_i, HEIGHT_o))
    for((a, b) <- matrix_i zip tmp.io.matrix_i)
      b <> a
    for((a, b) <- matrix_o zip tmp.io.matrix_o)
      b <> a
  }
}

class Reduction_3 (WIDTH: Int, HEIGHT_i: Int, HEIGHT_o: Int) extends Module{
  val io = IO(new Bundle {
    val matrix_o = Output(Vec(HEIGHT_o, Vec(WIDTH * 2, Bool())))
    val matrix_i = Input(Vec(HEIGHT_i, Vec(WIDTH * 2, Bool())))
  })
  def set_zero(m : Seq[Seq[Bool]], col:Int, row_start:Int, row_end:Int)={
    for (row <- row_start until row_end){
      m(row)(col) := false.B
    }
  }
  //col 0
  io.matrix_o(0)(0) := io.matrix_i(0)(0)
  set_zero(io.matrix_o, 0, 1, HEIGHT_o)
  //col 1
  io.matrix_o(0)(1) := io.matrix_i(0)(1)
  set_zero(io.matrix_o, 1, 1, HEIGHT_o)
  //col 2
  HA(io.matrix_i(0)(2), io.matrix_i(1)(2), io.matrix_o(0)(2), io.matrix_o(1)(3))
  set_zero(io.matrix_o, 2, 1, HEIGHT_o)
  //col 3
  io.matrix_o(0)(3) := io.matrix_i(0)(3)
  set_zero(io.matrix_o, 3, 2, HEIGHT_o)
  //col 4
  FA(io.matrix_i(0)(4), io.matrix_i(1)(4), io.matrix_i(2)(4), io.matrix_o(0)(4), io.matrix_o(1)(5))
  set_zero(io.matrix_o, 4, 1, HEIGHT_o)
  //col 5
  io.matrix_o(0)(5) := io.matrix_i(0)(5)
  io.matrix_o(2)(5) := io.matrix_i(1)(5)
  //col 6 - 8
  for (i <- 6 to 8){
    io.matrix_o(0)(i) := io.matrix_i(0)(i)
    io.matrix_o(1)(i) := io.matrix_i(1)(i)
    set_zero(io.matrix_o, i, 2 ,HEIGHT_o)
  }
  //col 9
  FA(io.matrix_i(0)(9), io.matrix_i(1)(9), io.matrix_i(2)(9), io.matrix_o(0)(9), io.matrix_o(1)(10))
  io.matrix_o(1)(9) := io.matrix_i(3)(9)
  set_zero(io.matrix_o, 9, 2, HEIGHT_o)
  //col 10 - 12
  for(i <- 10 to 12){
    FA(io.matrix_i(0)(i), io.matrix_i(1)(i), io.matrix_i(2)(i), io.matrix_o(0)(i), io.matrix_o(1)(i+1))
    set_zero(io.matrix_o, i, 2, HEIGHT_o)
  }
  //col 13 - 21
  for (i <- 13 to 21){
    FA(io.matrix_i(0)(i), io.matrix_i(1)(i), io.matrix_i(2)(i), io.matrix_o(0)(i), io.matrix_o(1)(i+1))
    io.matrix_o(2)(i) := io.matrix_i(3)(i)
  }
  //col 22
  FA(io.matrix_i(0)(22), io.matrix_i(1)(22), io.matrix_i(2)(22), io.matrix_o(0)(22), io.matrix_o(1)(23))
  set_zero(io.matrix_o, 22, 2, HEIGHT_o)
  //col 23
  FA(io.matrix_i(0)(23), io.matrix_i(1)(23), io.matrix_i(2)(23), io.matrix_o(0)(23), io.matrix_o(1)(24))
  io.matrix_o(2)(23) := io.matrix_i(3)(23)
  //col 24
  FA(io.matrix_i(0)(24), io.matrix_i(1)(24), io.matrix_i(2)(24), io.matrix_o(0)(24), io.matrix_o(1)(25))
  set_zero(io.matrix_o, 24, 2, HEIGHT_o)
  //col 25
  io.matrix_o(0)(25) := io.matrix_i(0)(25)
  io.matrix_o(2)(25) := io.matrix_i(1)(25)
  //col 26
  io.matrix_o(0)(26) := io.matrix_i(0)(26)
  io.matrix_o(1)(26) := io.matrix_i(1)(26)
  set_zero(io.matrix_o, 26, 2, HEIGHT_o)
  //col 27
  FA(io.matrix_i(0)(27), io.matrix_i(1)(27), io.matrix_i(2)(27), io.matrix_o(0)(27), io.matrix_o(1)(28))
  set_zero(io.matrix_o, 27, 1, HEIGHT_o)
  //col 28
  io.matrix_o(0)(28) := io.matrix_i(0)(28)
  io.matrix_o(2)(28) := io.matrix_i(1)(28)
  //col 29
  io.matrix_o(0)(29) := io.matrix_i(0)(29)
  set_zero(io.matrix_o, 29, 1, HEIGHT_o)
  //col 30
  FA(io.matrix_i(0)(30), io.matrix_i(1)(30), io.matrix_i(2)(30), io.matrix_o(0)(30), io.matrix_o(1)(31))
  set_zero(io.matrix_o, 30, 1, HEIGHT_o)
  //col 31
  io.matrix_o(0)(31) := io.matrix_i(0)(31)
  set_zero(io.matrix_o, 31, 2, HEIGHT_o)
}

object Reduction_3{
  def apply(matrix_i : Seq[Seq[Bool]], matrix_o: Seq[Seq[Bool]], WIDTH: Int, HEIGHT_i: Int, HEIGHT_o : Int) = {
    val tmp = Module(new Reduction_3(WIDTH, HEIGHT_i, HEIGHT_o))
    for((a, b) <- matrix_i zip tmp.io.matrix_i)
      b <> a
    for((a, b) <- matrix_o zip tmp.io.matrix_o)
      b <> a
  }
}

class Reduction_4 (WIDTH: Int, HEIGHT_i: Int, HEIGHT_o: Int) extends Module{
  val io = IO(new Bundle {
    val matrix_o = Output(Vec(HEIGHT_o, Vec(WIDTH * 2, Bool())))
    val matrix_i = Input(Vec(HEIGHT_i, Vec(WIDTH * 2, Bool())))
  })
  def set_zero(m : Seq[Seq[Bool]], col:Int, row_start:Int, row_end:Int)={
    for (row <- row_start until row_end){
      m(row)(col) := false.B
    }
  }
  //col 0 - 2
  for(i <- 0 to 2){
    io.matrix_o(0)(i) := io.matrix_i(0)(i)
    set_zero(io.matrix_o, i, 1, HEIGHT_o)
  }
  //col 3
  HA(io.matrix_i(0)(3), io.matrix_i(1)(3), io.matrix_o(0)(3), io.matrix_o(1)(4))
  set_zero(io.matrix_o, 3, 1, HEIGHT_o)
  //col 4
  io.matrix_o(0)(4) := io.matrix_i(0)(4)
  //col 5
  FA(io.matrix_i(0)(5),io.matrix_i(1)(5),io.matrix_i(2)(5), io.matrix_o(0)(5), io.matrix_o(1)(6))
  set_zero(io.matrix_o, 5, 1, HEIGHT_o)
  //col 6 - 12
  for (i <- 6 to 12){
    HA(io.matrix_i(0)(i), io.matrix_i(1)(i), io.matrix_o(0)(i), io.matrix_o(1)(i+1))
  }
  //col 13 - 21
  for (i <- 13 to 21){
    FA(io.matrix_i(0)(i), io.matrix_i(1)(i), io.matrix_i(2)(i), io.matrix_o(0)(i), io.matrix_o(1)(i+1))
  }
  //col 22
  HA(io.matrix_i(0)(22), io.matrix_i(1)(22), io.matrix_o(0)(22), io.matrix_o(1)(23))
  //col 23 - 26
  for (i <- 23 to 26 by 2){
    FA(io.matrix_i(0)(i), io.matrix_i(1)(i), io.matrix_i(2)(i), io.matrix_o(0)(i), io.matrix_o(1)(i+1))
    HA(io.matrix_i(0)(i+1), io.matrix_i(1)(i+1), io.matrix_o(0)(i+1), io.matrix_o(1)(i+2))
  }
  //col 27
  io.matrix_o(0)(27) := io.matrix_i(0)(27)
  //col 28
  FA(io.matrix_i(0)(28), io.matrix_i(1)(28), io.matrix_i(2)(28), io.matrix_o(0)(28), io.matrix_o(1)(29))
  set_zero(io.matrix_o, 28, 1, HEIGHT_o)
  //col 29
  io.matrix_o(0)(29) := io.matrix_i(0)(29)
  //col 30
  io.matrix_o(0)(30) := io.matrix_i(0)(30)
  set_zero(io.matrix_o, 30, 1, HEIGHT_o)
  //col 31
  io.matrix_o(0)(31) := io.matrix_i(0)(31)
  io.matrix_o(1)(31) := io.matrix_i(1)(31)
}

object Reduction_4 {
  def apply(matrix_i : Seq[Seq[Bool]], matrix_o: Seq[Seq[Bool]], WIDTH: Int, HEIGHT_i: Int, HEIGHT_o : Int) = {
    val tmp = Module(new Reduction_4(WIDTH, HEIGHT_i, HEIGHT_o))
    for((a, b) <- matrix_i zip tmp.io.matrix_i)
      b <> a
    for((a, b) <- matrix_o zip tmp.io.matrix_o)
      b <> a
  }
}

class TailAdder(WIDTH: Int) extends Module {
  val io = IO(new Bundle {
    val S = Output(UInt((WIDTH).W))
    val B = Input(UInt(WIDTH.W))
    val A = Input(UInt(WIDTH.W))
  })
  io.S := io.A + io.B
}

object TailAdder {
  def apply(A: UInt, B: UInt, S: UInt, WIDTH: Int) = {
    val tmp = Module(new TailAdder(WIDTH))
    tmp.io.A := A
    tmp.io.B := B
    S := tmp.io.S
  }
}
/*
class RA_Mul (WIDTH: Int, TailAdderWIDTH: Int) extends Module {
  val io = IO(new Bundle {
    val P = Output(UInt((WIDTH*2).W))
    val B = Input(UInt(WIDTH.W))
    val A = Input(UInt(WIDTH.W))
  })
  val PP = Wire(Vec(WIDTH/2, UInt(WIDTH.W)))
  val SS = Wire(UInt(WIDTH.W))
  val SC = Wire(UInt((WIDTH/2).W))
  val S = Wire(UInt((WIDTH/2).W))
  /*val BoothEncoder = Module(new BoothEncoder_radix4(WIDTH))
  val PPGenerator = Module(new PPGen(WIDTH))

  BoothEncoder.io.B := io.B
  PPGenerator.io.eB <> BoothEncoder.io.eB
  PPGenerator.io.A := io.A
  io.PP <> PPGenerator.io.PP
  io.SS := PPGenerator.io.SS
  io.SC := PPGenerator.io.SC
  io.S := PPGenerator.io.S
  */
  val eB = Wire(Vec(WIDTH/2, UInt(3.W)))
  val matrix_o1 = Wire(Vec(6, Vec(WIDTH * 2, Bool())))
  val matrix_o2 = Wire(Vec(4, Vec(WIDTH * 2, Bool())))
  val matrix_o3 = Wire(Vec(3, Vec(WIDTH * 2, Bool())))
  val matrix_o4 = Wire(Vec(2, Vec(WIDTH * 2, Bool())))
  BoothEncoder_radix4(io.B, eB, WIDTH)
  PPGen(io.A, eB, PP, SS, SC, S, WIDTH)
  Reduction_1(PP, SS, SC, S, matrix_o1, WIDTH, 6)
  Reduction_2(matrix_o1, matrix_o2, WIDTH, 6, 4)
  Reduction_3(matrix_o2, matrix_o3, WIDTH, 4, 3)
  Reduction_4(matrix_o3, matrix_o4, WIDTH, 3, 2)
  TailAdder(matrix_o4(0).asUInt, matrix_o4(1).asUInt, io.P, TailAdderWIDTH)

}
*/

class PPLRegs1 (WIDTH: Int) extends  Module {
  val io = IO(new Bundle {
    val PP_i = Input(Vec(WIDTH/2, UInt(WIDTH.W)))
    val PP_o = Output(Vec(WIDTH/2, UInt(WIDTH.W)))
    val SS_i = Input(UInt(WIDTH.W))
    val SS_o = Output(UInt(WIDTH.W))
    val SC_i = Input(UInt((WIDTH/2).W))
    val SC_o = Output(UInt((WIDTH/2).W))
    val S_i = Input(UInt((WIDTH/2).W))
    val S_o = Output(UInt((WIDTH/2).W))
  })
  io.PP_o := RegNext(io.PP_i, Vec(Seq.fill(WIDTH/2){0.U}))
  io.SS_o := RegNext(io.SS_i, 0.U)
  io.SC_o := RegNext(io.SC_i, 0.U)
  io.S_o := RegNext(io.S_i, 0.U)
}

object PPLRegs1 {
  def apply(PP_i : Seq[UInt], SS_i: UInt, SC_i: UInt, S_i: UInt,PP_o : Seq[UInt], SS_o: UInt, SC_o: UInt, S_o: UInt, WIDTH: Int) = {
    val tmp = Module(new PPLRegs1(WIDTH))
    tmp.io.PP_i <> PP_i
    for ((a, b) <- tmp.io.PP_o zip PP_o){
      b := a
    }
    tmp.io.SS_i := SS_i
    SS_o := tmp.io.SS_o
    tmp.io.SC_i := SC_i
    SC_o := tmp.io.SC_o
    tmp.io.S_i := S_i
    S_o := tmp.io.S_o
  }
}

class PPLRegs2 (WIDTH: Int, HEIGHT_i: Int, HEIGHT_o:Int) extends  Module {
  val io = IO(new Bundle {
    val matrix_o = Output(Vec(HEIGHT_o, Vec(WIDTH * 2, Bool())))
    val matrix_i = Input(Vec(HEIGHT_i, Vec(WIDTH * 2, Bool())))
  })
  //for((a, b) <- io.matrix_i zip io.matrix_o)
   // b := RegNext(a, VecInit(Seq.fill(WIDTH * 2){false.B}))
  val tmp = Wire(Vec(HEIGHT_o, UInt((WIDTH*2).W)))
  for((a, b) <- io.matrix_i zip tmp){
    b := (RegNext(a.asUInt, 0.U))
  }
  for((a,b) <- io.matrix_o zip tmp){
    a := b.toBools
  }
}

object PPLRegs2 {
  def apply(matrix_i:Seq[Seq[Bool]], matrix_o:Seq[Seq[Bool]], WIDTH: Int, HEIGHT_i: Int, HEIGHT_o:Int) = {
    val tmp = Module(new PPLRegs2(WIDTH, HEIGHT_i, HEIGHT_o))
    for((a, b) <- matrix_o zip tmp.io.matrix_o)
      b <> a
    for((a, b) <- matrix_i zip tmp.io.matrix_i)
      b <> a
  }
}

class PPLRegs3 (WIDTH: Int) extends  Module {
  val io = IO(new Bundle {
    val S_o = Output(UInt((WIDTH).W))
    val S_i = Input(UInt((WIDTH).W))
  })
  io.S_o := RegNext(io.S_i, 0.U)
}

object PPLRegs3 {
  def apply(S_i: UInt, S_o: UInt, WIDTH: Int) = {
    val tmp = Module(new PPLRegs3(WIDTH))
    tmp.io.S_i := S_i
    S_o := tmp.io.S_o
  }
}

class RA_Mul  extends Module {
  val WIDTH=32
  val TailAdderWIDTH= 64
  val io = IO(new Bundle {
    val P = Output(UInt((WIDTH*2).W))
    //val B = Input(UInt(WIDTH.W))
    //val A = Input(UInt(WIDTH.W))
  })
  val A = Wire(UInt(WIDTH.W))
  val B = Wire(UInt(WIDTH.W))
  val PP = Wire(Vec(WIDTH/2, UInt(WIDTH.W)))
  val SS = Wire(UInt(WIDTH.W))
  val SC = Wire(UInt((WIDTH/2).W))
  val S = Wire(UInt((WIDTH/2).W))

  val PP_o = Wire(Vec(WIDTH/2, UInt(WIDTH.W)))
  val SS_o = Wire(UInt(WIDTH.W))
  val SC_o = Wire(UInt((WIDTH/2).W))
  val S_o = Wire(UInt((WIDTH/2).W))

  val eB = Wire(Vec(WIDTH/2, UInt(3.W)))
  val matrix_o1 = Wire(Vec(6, Vec(WIDTH * 2, Bool())))
  val matrix_o2 = Wire(Vec(4, Vec(WIDTH * 2, Bool())))
  val matrix_o3 = Wire(Vec(3, Vec(WIDTH * 2, Bool())))
  val matrix_o4 = Wire(Vec(2, Vec(WIDTH * 2, Bool())))
  val matrix_o4_o = Wire(Vec(2, Vec(WIDTH * 2, Bool())))
  val P = Wire(UInt((WIDTH*2).W))

  val input_gen = Module(new LSFR_NEW)
  A := input_gen.io.out
  B := input_gen.io.out
  BoothEncoder_radix4(B, eB, WIDTH)
  PPGen(A, eB, PP, SS, SC, S, WIDTH)
  PPLRegs1(PP, SS, SC, S, PP_o, SS_o, SC_o, S_o, WIDTH)

  Reduction_1(PP_o, SS_o, SC_o, S_o, matrix_o1, WIDTH, 6)
  Reduction_2(matrix_o1, matrix_o2, WIDTH, 6, 4)
  Reduction_3(matrix_o2, matrix_o3, WIDTH, 4, 3)
  Reduction_4(matrix_o3, matrix_o4, WIDTH, 3, 2)
  PPLRegs2(matrix_o4, matrix_o4_o, WIDTH, 2, 2)

  TailAdder(matrix_o4_o(0).asUInt, matrix_o4_o(1).asUInt, P, TailAdderWIDTH)
  PPLRegs3(P, io.P, TailAdderWIDTH)
}

