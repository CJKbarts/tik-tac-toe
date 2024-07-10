class Game
  attr_reader :board, :player_1, :player_2, :continue_game

  def initialize
    board = Board.new
    player_1 = Player.new(1)
    player_2 = Player.new(2)
    continue_game = true
  end

  def play_game
    while continue_game
      round_winner = play_round(board, player_1, player_2)
      if round_winner.nil?
        puts 'This round was a draw'
      else
        puts "#{round_winner} won this game"
      end

      puts
      continue_game = should_continue?
      if continue_game
        board.clear
        player_1.reset_turns_played
        player_2.reset_turns_played
      else
        case player_1.compare(player_2)
        when 0
          puts 'The game was a draw'
        when 1
          puts 'Player 1 won the game!!!'
        when -1
          puts 'Player 2 won the game!!!'
        end
      end
    end
  end

  def play_round(board, p1, p2)
    found_winner = false
    winner = nil
    count = 1

    until found_winner
      board.display
      current_player = count.odd? ? p1 : p2
      current_player.play_turn(board)
      count += 1
      if current_player.turns_played >= 3 && current_player.won?(board)
        found_winner = true
        winner = current_player
      elsif count == 9
        break
      end
    end

    winner
  end

  def continue?
    print 'Play another round? (y/n): '
    input = player_input(/[yn]/, "Invalid Input. Please enter 'y' or 'n': ")
    if input == 'y'
      reset_game
      play_game
    else
      game_results
    end
  end

  def player_input(criteria, error_message)
    input = gets.chomp.downcase
    until input.match?(criteria)
      print error_message
      input = gets.chomp.downcase
    end

    input
  end

  def reset_game
  end

  def game_results
  end
end
