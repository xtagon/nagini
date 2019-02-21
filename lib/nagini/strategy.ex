defmodule Nagini.Strategy do
  alias Nagini.Strategy

  @moves ~w(up down left right)
  @fallback_move "up"

  defstruct [safe_moves: nil]

  import Nagini.Pathfinding

  def decide(state), do: decide(%Strategy{}, state)

  def decide(%Strategy{safe_moves: nil}, state) do
    moves = Enum.filter(@moves, &(safe_move?(state, &1)))
    strategy = %Strategy{safe_moves: moves}
    decide(strategy, state)
  end

  def decide(%Strategy{safe_moves: []}, _state)  do
    @fallback_move # The only winning move is not to play
  end

  def decide(%Strategy{safe_moves: moves}, _state) when length(moves) == 1 do
    Enum.at(moves, 0)
  end

  def decide(%Strategy{safe_moves: moves}, _state) do
    Enum.random(moves)
  end

  def move(_strategy, _state), do: @fallback_move
end
