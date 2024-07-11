class Game
  attr_reader :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
  end

  def play_round
    winner = find_winner
    board.display
    round_results(winner)
    continue?
  end

  def find_winner
    9.times do |count|
      board.display
      current_player = count.even? ? player1 : player2
      current_player.play_turn(board)
      return current_player if current_player.turns_played >= 3 && current_player.won?(board)
    end

    nil
  end

  def round_results(winner)
    if winner.nil?
      puts 'This round was a draw'
    else
      puts "#{winner} won this round"
    end
    puts
  end

  def continue?
    input = player_input(/[yn]/, 'Play another round? (y/n): ', "Invalid Input. Please enter 'y' or 'n': ")
    if input == 'y'
      reset_game
      play_round
    else
      game_results
    end
  end

  def player_input(criteria, prompt, error_message)
    print prompt
    input = gets.chomp.downcase
    until input.match?(criteria)
      print error_message
      input = gets.chomp.downcase
    end

    input
  end

  def reset_game
    board.clear
    player1.reset_turns_played
    player2.reset_turns_played
  end

  def game_results
    case player1.compare(player2)
    when 0
      puts 'The game was a draw'
    when 1
      puts 'Player 1 won the game!!!'
    when -1
      puts 'Player 2 won the game!!!'
    end
  end
end
