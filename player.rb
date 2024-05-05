class Player
  attr_accessor :player_num, :symbol

  def initialize(player_num)
    self.player_num = player_num
    @turns_played = 0
    assign_symbol(player_num)
  end

  def play_turn(board)
    turn_coord = get_coordinates(board)
    board.fill_cell(turn_coord, symbol)
    @current_play = turn_coord
  end

  def won?(board)
    board.row_equal?(@current_play[0], symbol) ||
      board.column_equal?(@current_play[1], symbol) ||
      board.diagonal_equal?(@current_play, symbol)
  end

  private

  def assign_symbol(player_num)
    @symbol = (player_num == 1) ? 'X' : 'O'
  end

  def get_coordinates(board)
    x_coord = nil
    y_coord = nil

    loop do
      puts "Player #{@player_num} enter x coordinate: "
      x_coord = gets.chomp.to_i
      puts "Player #{@player_num} enter y coordinate: "
      y_coord = gets.chomp.to_i

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
end
