require_relative '../lib/game/display'
require_relative '../lib/game/board'

describe Board do
  describe '#row_complete?' do
    subject(:board_row) { described_class.new }
    let(:grid) { board_row.instance_variable_get(:@grid) }
    let(:row_index) { 0 }
    let(:symbol) { 'X' }

    context 'when the row is filled with one symbol' do
      before do
        grid[row_index] = Array.new(3, symbol)
      end

      it 'returns true' do
        expect(board_row.row_complete?(row_index, symbol)).to eql(true)
      end
    end

    context 'when the row is filled with different symbols' do
      before do
        grid[row_index] = %w[X O X]
      end

      it 'returns false' do
        expect(board_row.row_complete?(row_index, symbol)).to eql(false)
      end
    end

    context 'when the row is empty' do
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
        grid[0][column_index] = symbol
        grid[1][column_index] = symbol
        grid[2][column_index] = symbol
      end

      it 'returns true' do
        expect(board_column.column_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when the column is filled with different symbols' do
      before do
        grid[0][column_index] = symbol
        grid[1][column_index] = 'O'
        grid[2][column_index] = symbol
      end

      it 'returns false' do
        expect(board_column.column_complete?(column_index, symbol)).to eql(false)
      end
    end

    context 'when the column is empty' do
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
        grid[0][0] = symbol
        grid[1][1] = symbol
        grid[2][2] = symbol
      end

      it 'returns true' do
        expect(board_r_diagonal.right_diagonal_complete?(symbol)).to eql(true)
      end
    end

    context 'when the right diagonal is filled with different symbols' do
      before do
        grid[0][0] = symbol
        grid[1][1] = 'O'
        grid[2][2] = symbol
      end

      it 'returns false' do
        expect(board_r_diagonal.right_diagonal_complete?(symbol)).to eql(false)
      end
    end

    context 'when the right diagonal is empty' do
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
        grid[0][2] = symbol
        grid[1][1] = symbol
        grid[2][0] = symbol
      end

      it 'returns true' do
        expect(board_l_diagonal.left_diagonal_complete?(symbol)).to eql(true)
      end
    end

    context 'when the left diagonal is filled with different symbols' do
      before do
        grid[0][2] = symbol
        grid[1][1] = 'O'
        grid[2][0] = symbol
      end

      it 'returns false' do
        expect(board_l_diagonal.left_diagonal_complete?(symbol)).to eql(false)
      end
    end

    context 'when the left diagonal is empty' do
      before do
        grid[0][2] = 'C'
        grid[1][1] = 'E'
        grid[2][0] = 'G'
      end

      it 'returns false' do
        expect(board_l_diagonal.left_diagonal_complete?(symbol)).to eql(false)
      end
    end
  end

  describe '#empty?' do
    subject(:board_empty) { described_class.new }
    let(:grid) { board_empty.instance_variable_get(:@grid) }
    let(:coordinates) { [0, 0] }

    context 'when the cell is empty' do
      before do
        allow(board_empty).to receive(:cell).and_return(grid[0][0])
      end

      it 'returns true' do
        expect(board_empty.empty?(coordinates)).to eql(true)
      end
    end

    context 'when the cell is filled' do
      before do
        grid[0][0] = 'X'
        allow(board_empty).to receive(:cell).and_return(grid[0][0])
      end

      it 'returns false' do
        expect(board_empty.empty?(coordinates)).to eql(false)
      end
    end
  end

  describe '#fill' do
    subject(:board_fill) { described_class.new }
    let(:grid) { board_fill.instance_variable_get(:@grid) }
    let(:symbol) { 'X' }
    let(:coordinates) { [0, 0] }

    it 'changes cell to given symbol' do
      expect { board_fill.fill(coordinates, symbol) }.to change { grid[0][0] }.to(symbol)
    end
  end
end
