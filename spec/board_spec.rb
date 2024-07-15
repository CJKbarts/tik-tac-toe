require_relative '../lib/game/display'
require_relative '../lib/game/cell'
require_relative '../lib/game/board'

describe Board do
  describe '#row_complete?' do
    subject(:board_row) { described_class.new }
    let(:row) { board_row.instance_variable_get(:@grid)[row_index] }
    let(:row_index) { 0 }
    let(:symbol) { 'X' }

    context 'when the row is filled with one symbol' do
      before do
        allow(row[0]).to receive(:content).and_return(symbol)
        allow(row[1]).to receive(:content).and_return(symbol)
        allow(row[2]).to receive(:content).and_return(symbol)
      end

      it 'returns true' do
        expect(board_row.row_complete?(row_index, symbol)).to eql(true)
      end
    end

    context 'when the row is filled with different symbols' do
      before do
        allow(row[0]).to receive(:content).and_return(symbol)
        allow(row[1]).to receive(:content).and_return('O')
        allow(row[2]).to receive(:content).and_return(symbol)
      end

      it 'returns false' do
        expect(board_row.row_complete?(row_index, symbol)).to eql(false)
      end
    end

    context 'when the row is empty' do
      before do
        allow(row[0]).to receive(:content).and_return('A')
        allow(row[1]).to receive(:content).and_return('B')
        allow(row[2]).to receive(:content).and_return('C')
      end

      it 'returns false' do
        expect(board_row.row_complete?(row_index, symbol)).to eql(false)
      end
    end
  end

  describe '#column_complete?' do
    subject(:board_column) { described_class.new }
    let(:grid) { board_column.instance_variable_get(:@grid) }
    let(:column_index) { 0 }
    let(:symbol) { 'X' }

    context 'when the column is filled with one symbol' do
      before do
        allow(grid[0][column_index]).to receive(:content).and_return(symbol)
        allow(grid[1][column_index]).to receive(:content).and_return(symbol)
        allow(grid[2][column_index]).to receive(:content).and_return(symbol)
      end

      it 'returns true' do
        expect(board_column.column_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when the column is filled with different symbols' do
      before do
        allow(grid[0][column_index]).to receive(:content).and_return(symbol)
        allow(grid[1][column_index]).to receive(:content).and_return('O')
        allow(grid[2][column_index]).to receive(:content).and_return(symbol)
      end

      it 'returns false' do
        expect(board_column.column_complete?(column_index, symbol)).to eql(false)
      end
    end

    context 'when the column is empty' do
      before do
        allow(grid[0][column_index]).to receive(:content).and_return('A')
        allow(grid[1][column_index]).to receive(:content).and_return('D')
        allow(grid[2][column_index]).to receive(:content).and_return('G')
      end

      it 'returns false' do
        expect(board_column.column_complete?(column_index, symbol)).to eql(false)
      end
    end
  end

  describe '#right_diagonal_complete?' do
    subject(:board_r_diagonal) { described_class.new }
    let(:grid) { board_r_diagonal.instance_variable_get(:@grid) }
    let(:symbol) { 'X' }

    context 'when the right diagonal is filled with a symbol' do
      before do
        allow(grid[0][0]).to receive(:content).and_return(symbol)
        allow(grid[1][1]).to receive(:content).and_return(symbol)
        allow(grid[2][2]).to receive(:content).and_return(symbol)
      end

      it 'returns true' do
        expect(board_r_diagonal.right_diagonal_complete?(symbol)).to eql(true)
      end
    end

    context 'when the right diagonal is filled with different symbols' do
      before do
        allow(grid[0][0]).to receive(:content).and_return(symbol)
        allow(grid[1][1]).to receive(:content).and_return('O')
        allow(grid[2][2]).to receive(:content).and_return(symbol)
      end

      it 'returns false' do
        expect(board_r_diagonal.right_diagonal_complete?(symbol)).to eql(false)
      end
    end

    context 'when the right diagonal is empty' do
      before do
        allow(grid[0][0]).to receive(:content).and_return('A')
        allow(grid[1][1]).to receive(:content).and_return('E')
        allow(grid[2][2]).to receive(:content).and_return('I')
      end

      it 'returns false' do
        expect(board_r_diagonal.right_diagonal_complete?(symbol)).to eql(false)
      end
    end
  end

  describe '#left_diagonal_complete?' do
    subject(:board_l_diagonal) { described_class.new }
    let(:grid) { board_l_diagonal.instance_variable_get(:@grid) }
    let(:symbol) { 'X' }

    context 'when the left diagonal is filled with a symbol' do
      before do
        allow(grid[0][2]).to receive(:content).and_return(symbol)
        allow(grid[1][1]).to receive(:content).and_return(symbol)
        allow(grid[2][0]).to receive(:content).and_return(symbol)
      end

      it 'returns true' do
        expect(board_l_diagonal.left_diagonal_complete?(symbol)).to eql(true)
      end
    end

    context 'when the left diagonal is filled with different symbols' do
      before do
        allow(grid[0][2]).to receive(:content).and_return(symbol)
        allow(grid[1][1]).to receive(:content).and_return('O')
        allow(grid[2][0]).to receive(:content).and_return(symbol)
      end

      it 'returns false' do
        expect(board_l_diagonal.left_diagonal_complete?(symbol)).to eql(false)
      end
    end

    context 'when the left diagonal is empty' do
      before do
        allow(grid[0][2]).to receive(:content).and_return('C')
        allow(grid[1][1]).to receive(:content).and_return('E')
        allow(grid[2][0]).to receive(:content).and_return('G')
      end

      it 'returns false' do
        expect(board_l_diagonal.left_diagonal_complete?(symbol)).to eql(false)
      end
    end
  end
end
