package StroberExample

import Chisel._
import Designs._
import TutorialExamples._
import mini.Core
import mini.Tile
import strober._

object StroberExample {
  def main(args: Array[String]) {
    val (chiselArgs, testArgs) = args.tail partition (_.head != '+')
    val res = args(0) match {
      /* case "RiscSRAM" =>
        chiselMainTest(chiselArgs, () => Module(new RiscSRAM))(
          c => new RiscSRAMTests(c)) */
      case "RiscSRAMStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new RiscSRAM))(
          c => new RiscSRAMStroberTests(c))
      case "RiscStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new Risc))(
          c => new RiscStroberTests(c)) 
      case "GCDStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new GCD))(
          c => new GCDStroberTests(c))
      case "ParityStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new Parity))(
          c => new ParityStroberTests(c))
      case "StackStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new Stack(8)))(
          c => new StackStroberTests(c))
      case "RouterStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new Router))(
          c => new RouterStroberTests(c))
      case "ShiftRegisterStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new ShiftRegister))(
          c => new ShiftRegisterStroberTests(c))
      case "ResetShiftRegisterStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new ResetShiftRegister))(
          c => new ResetShiftRegisterStroberTests(c))
      case "EnableShiftRegisterStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new EnableShiftRegister))(
          c => new EnableShiftRegisterStroberTests(c))
      case "MemorySearchStrober" =>
        chiselMainTest(chiselArgs, () => Strober(new MemorySearch))(
          c => new MemorySearchStroberTests(c))
      case "TileStrober" => 
        chiselMainTest(chiselArgs, () => Strober(new Tile, mini.Config.params))(
          c => new TileStroberTests(c, testArgs))

      case "RiscSRAM" =>
        chiselMainTest(chiselArgs, () => Module(new RiscSRAM))(c => new Replay(c))
      case "Risc" =>
        chiselMainTest(chiselArgs, () => Module(new Risc))(c => new Replay(c))
      case "GCD" =>
        chiselMainTest(chiselArgs, () => Module(new GCD))(c => new Replay(c))
      case "Parity" =>
        chiselMainTest(chiselArgs, () => Module(new Parity))(c => new Replay(c))
      case "Stack" =>
        chiselMainTest(chiselArgs, () => Module(new Stack(8)))(c => new Replay(c))
      case "Router" =>
        chiselMainTest(chiselArgs, () => Module(new Router))(c => new Replay(c))
      case "ShiftRegister" =>
        chiselMainTest(chiselArgs, () => Module(new ShiftRegister))(c => new Replay(c))
      case "ResetShiftRegister" =>
        chiselMainTest(chiselArgs, () => Module(new ResetShiftRegister))(c => new Replay(c))
      case "EnableShiftRegister" =>
        chiselMainTest(chiselArgs, () => Module(new EnableShiftRegister))(c => new Replay(c))
      case "MemorySearch" =>
        chiselMainTest(chiselArgs, () => Module(new MemorySearch))(c => new Replay(c))
      case "Tile" => 
        chiselMainTest(chiselArgs, () => Module(new Tile)(mini.Config.params))(
          c => new TileReplay(c, testArgs))
      case _ =>
    }
  }
}
