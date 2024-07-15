class Player
  include Display
  attr_reader :turns_played, :rounds_won, :symbol

  def initialize(player_num)
    @player_num = player_num
    @turns_played = 0
    @rounds_won = 0
    assign_symbol(player_num)
  end

  def assign_symbol(player_num)
    @symbol = player_num == 1 ? 'X' : 'O'
  end

  def play_turn(board)
    cell = choose_cell(board)
    board.fill(cell, symbol)
    @current_cell = cell
    @turns_played += 1
  end

  def choose_cell(board)
    choice = []
    until board.empty?(choice)
      input = player_input(/[A-I]/, "#{self} choose an empty cell: ",
                           'That is not a valid cell. Choose again: ')
      choice = convert_to_coordinates(input)
    end
    choice
  end

  def player_input(criteria, prompt, error_message)
    print prompt
    input = gets.chomp.upcase
    until input.match?(criteria)
      print error_message
      input = gets.chomp.upcase
    end

    input
  end

  def won?(board)
    result = board.row_complete?(current_cell[0], symbol) ||
             board.column_complete?(current_cell[1], symbol) ||
             board.diagonal_complete?(symbol)
    increase_rounds_won if result
    result
  end

  def to_s
    "Player #{@player_num}"
  end

  def reset_turns_played
    @turns_played = 0
  end

  def compare(other)
    rounds_won <=> other.rounds_won
  end

  private

  attr_reader :current_cell

  def increase_rounds_won
    @rounds_won += 1
  end
end
