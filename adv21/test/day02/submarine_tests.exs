defmodule SubmarineTest do
  use ExUnit.Case
  alias Adv21.Day02.Submarine
  doctest Adv21.Day02.Submarine

  test "course position for example file returns 150" do
    course_position = Submarine.follow_course("test/day02/example.txt")
    IO.puts("Course position in example file #{course_position} ")
    assert course_position == 150
  end

  test "course position for input file" do
    course_position = Submarine.follow_course("lib/day02/input.txt")
    IO.puts("Course position in example file #{course_position} ")
  end

  test "course position with aim for example file returns 900" do
    course_position = Submarine.follow_course_with_aim("test/day02/example.txt")
    IO.puts("Course position in example file (with aim) #{course_position} ")
    assert course_position == 900
  end

  test "course position with aim for input file" do
    course_position = Submarine.follow_course_with_aim("lib/day02/input.txt")
    IO.puts("Course position in example file (with aim) #{course_position} ")
  end
end
