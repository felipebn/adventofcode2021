defmodule Adv21.Day02.Submarine do

  def follow_course(filename) do
    {x, y} = File.stream!(filename)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn step -> String.split(step, " ") end)
    |> Enum.map(fn [direction, value] -> {direction, String.to_integer(value)} end)
    |> Enum.reduce({0, 0}, fn step, {xx,yy} ->
      case step do
        {"forward", count} -> {xx + count, yy}
        {"down", count} -> {xx, yy + count}
        {"up", count} -> {xx, yy - count}
      end
    end)

    x*y
  end

  def follow_course_with_aim(filename) do
    {_, x, y} = File.stream!(filename)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn step -> String.split(step, " ") end)
    |> Enum.map(fn [direction, value] -> {direction, String.to_integer(value)} end)
    |> Enum.reduce({0, 0, 0}, fn step, {aim, xx, yy} ->
      case step do
        {"forward", value} -> {aim, xx + value, yy + (aim * value)}
        {"down", value} -> {aim + value, xx, yy}
        {"up", value} -> {aim - value, xx, yy}
      end
    end)

    x*y
  end
end
