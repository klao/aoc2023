import Lake
open Lake DSL

package «aoc2023» where
  -- add package configuration options here

lean_lib «Aoc2023» where
  -- add library configuration options here

-- @[default_target]
lean_exe «day00» where
  root := `Day00
