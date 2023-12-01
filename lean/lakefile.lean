import Lake
open Lake DSL

package «aoc2023» where
  -- require std from git "https://github.com/leanprover/std4"
  -- add package configuration options here

lean_lib «Aoc2023» where
  -- add library configuration options here

@[default_target]
lean_exe «day01» where
  root := `Day01
