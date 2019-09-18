defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  use Bitwise

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    list_of_commands = [{"wink", 1}, {"double blink" , 2}, {"close your eyes",  4}, {"jump", 8}]

    check = fn code, command_value -> (code &&& command_value ) == command_value end
    should_reverse = check.(code, 16)

    handshake = Enum.reduce(list_of_commands, [], fn {command, value}, acc ->
      #TODO the acc list is being read all the way for each reduce() iteraction to put a new element
      if check.(code, value), do: acc ++ [command], else: acc
    end)
  
  if should_reverse, do: Enum.reverse(handshake), else: handshake
  end
end
