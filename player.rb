class Player
  def initialize(num)
    @player_num = num
    @turns_played = 0
  end

  def play_turn(board)
    turn_coord = get_coordinates(board)
    board.fill_cell(turn_coord, player_num)
  end

  private

  def player_num
    @player_num
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
