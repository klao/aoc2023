def digits : List (String × Nat) := [
  ("one", 1),
  ("two", 2),
  ("three", 3),
  ("four", 4),
  ("five", 5),
  ("six", 6),
  ("seven", 7),
  ("eight", 8),
  ("nine", 9),
]

def String.reverse (s : String) : String :=
  s.toList.reverse.asString

def reversedDigits : List (String × Nat) := digits.map (fun (s, n) => (s.reverse, n))

def namedDigit (digits : List (String × Nat)) (s : String) : Option Nat :=
  let rec loop : List (String × Nat) -> Option Nat
    | [] => none
    | (name, digit) :: ds => if s.startsWith name
      then some digit
      else loop ds
  loop digits

def firstDigit (digits : List (String × Nat)) (s : String): Option Nat :=
  let rec loop : List Char -> Option Nat
    | [] => none
    | c :: cs => if c.isDigit
      then some (c.toNat - '0'.toNat)
      else match namedDigit digits ⟨c :: cs⟩ with
        | some n => some n
        | none => loop cs
  loop s.toList

def part1Line (line : String) : Nat :=
  let first := (line.get! (line.find Char.isDigit) |>.toNat) - '0'.toNat
  let last := (line.get! (line.revFind Char.isDigit |>.get!) |>.toNat) - '0'.toNat
  10 * first + last

def part2Line (line : String) : Nat :=
  let first := firstDigit digits line |>.get!
  let last := firstDigit reversedDigits line.reverse |>.get!
  10 * first + last

def main : IO Unit := do
  let inp ← IO.FS.lines "../in/i01.txt"
  IO.println (inp.foldl (· + part1Line ·) 0)
  IO.println (inp.foldl (· + part2Line ·) 0)
