require_relative '../lib/game/player'
require_relative '../lib/game/cell'
require_relative '../lib/game/board'
require_relative '../lib/game'

describe Game do
  describe '#find_winner' do
    subject(:game_winner) { described_class.new }

    context 'when player 1 wins' do
      before do
        allow(game_winner.board).to receive(:display)
        allow(game_winner.player1).to receive(:play_turn)
        allow(game_winner.player2).to receive(:play_turn)
        allow(game_winner.player1).to receive(:turns_played).and_return(3)
        allow(game_winner.player1).to receive(:won?).and_return(true)
      end

      it 'returns player 1' do
        expect(game_winner.find_winner).to eql(game_winner.player1)
      end
    end

    context 'when player 2 wins' do
      before do
        allow(game_winner.board).to receive(:display)
        allow(game_winner.player1).to receive(:play_turn)
        allow(game_winner.player2).to receive(:play_turn)
        allow(game_winner.player2).to receive(:turns_played).and_return(3)
        allow(game_winner.player2).to receive(:won?).and_return(true)
      end

      it 'returns player 2' do
        expect(game_winner.find_winner).to eql(game_winner.player2)
      end
    end

    context 'when no player wins' do
      before do
        allow(game_winner.board).to receive(:display)
        allow(game_winner.player1).to receive(:play_turn)
        allow(game_winner.player2).to receive(:play_turn)
      end

      it 'returns nil' do
        expect(game_winner.find_winner).to be_nil
      end
    end
  end

  describe '#player_input' do
    subject(:game_input) { described_class.new }
    let(:criteria) { /[yn]/ }
    let(:prompt) { 'Play another round? (y/n): ' }
    let(:error_message) { "Invalid Input. Please enter 'y' or 'n': " }

    context 'when the player provides a valid input' do
      before do
        allow(game_input).to receive(:gets).and_return('y')
        allow(game_input).to receive(:print)
      end

      it 'returns the valid input' do
        expect(game_input.player_input(criteria, prompt, error_message)).to eql('y')
      end

      it 'does not print the error message' do
        expect(game_input).to_not receive(:print).with(error_message)
        game_input.player_input(criteria, prompt, error_message)
      end
    end

    context 'when the player provides an invalid input' do
      before do
        allow(game_input).to receive(:gets).and_return('5', 'y')
        allow(game_input).to receive(:print)
      end

      it 'prints the error message once' do
        expect(game_input).to receive(:print).with(error_message).once
        game_input.player_input(criteria, prompt, error_message)
      end

      it 'returns the valid input' do
        expect(game_input.player_input(criteria, prompt, error_message)).to eql('y')
      end
    end

    context 'when the player provides an invalid input twice' do
      before do
        allow(game_input).to receive(:gets).and_return('5', 'f', 'y')
        allow(game_input).to receive(:print)
      end

      it 'prints the error message once' do
        expect(game_input).to receive(:print).with(error_message).twice
        game_input.player_input(criteria, prompt, error_message)
      end

      it 'returns the valid input' do
        expect(game_input.player_input(criteria, prompt, error_message)).to eql('y')
      end
    end
  end

  describe '#reset_game' do
    subject(:game_reset) { described_class.new }

    before do
      allow(game_reset.board).to receive(:clear)
      allow(game_reset.player1).to receive(:reset_turns_played)
      allow(game_reset.player2).to receive(:reset_turns_played)
    end

    it 'calls #clear on board' do
      expect(game_reset.board).to receive(:clear)
      game_reset.reset_game
    end

    it 'calls #reset_turns_played on both players' do
      expect(game_reset.player1).to receive(:reset_turns_played)
      expect(game_reset.player2).to receive(:reset_turns_played)
      game_reset.reset_game
    end
  end
end
