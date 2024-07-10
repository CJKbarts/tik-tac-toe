class Player
  attr_accessor :symbol
  attr_reader :turns_played

  def initialize(player_num)
    @player_num = player_num
    @turns_played = 0
    @rounds_won = 0
    assign_symbol(player_num)
  end

  def play_turn(board)
    turn_coord = get_coordinates(board)
    board.fill_cell(turn_coord, symbol)
    @current_play = turn_coord
    @turns_played += 1
  end

  def won?(board)
    result = board.row_equal?(@current_play[0], symbol) ||
             board.column_equal?(@current_play[1], symbol) ||
             board.diagonal_equal?(@current_play, symbol)
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
    if self.rounds_won == other.rounds_won
      return 0
    elsif self.rounds_won > other.rounds_won
      return 1
    else
      return -1
    end
  end

  protected

  def rounds_won
    @rounds_won
  end

  private

  def assign_symbol(player_num)
    @symbol = (player_num == 1) ? ' X' : ' O'
  end

  def get_coordinates(board)
    x_coord = nil
    y_coord = nil
    loop do
      puts "Player #{@player_num} enter coordinates: "
      input = gets.chomp
      x_coord = input[0].to_i
      y_coord = input[1].to_i

      if board.get_cell(x_coord, y_coord).is_filled
        puts "That cell is filled. Pick a different one"
      else
        break
      end
    end

    result = []
    result.push(x_coord)
    result.push(y_coord)
  end

  def increase_rounds_won
    @rounds_won += 1
  end
end
