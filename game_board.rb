module GameBoard
  class Board
    def initialize
      @grid = create_grid
    end

    def display
      for row in @grid
        for cell in row
          print cell.content
        end

        puts "\n"
      end
    end

    def fill_cell(coordinates, symbol)
      x_coord = coordinates[0]
      y_coord = coordinates[1]
      @grid[x_coord][y_coord].fill(symbol)
    end

    def get_cell(x, y)
      @grid[x][y]
    end

    def row_equal?(row_num, symbol)
      grid[row_num].all? { |cell| cell.content == symbol }
    end

    def column_equal?(column_num, symbol)
      column = grid.map { |row| row[column_num].content }
      column.all?(symbol)
    end

    def diagonal_equal?(coordinates, symbol)
      if (coordinates[0] == coordinates[1] && coordinates[0] + coordinates[1] == 2)
        return right_diagonal_equal?(symbol) || left_diagonal_equal?(symbol)
      elsif coordinates[0] + coordinates[1] == 2
        return left_diagonal_equal?(symbol)
      elsif coordinates[0] == coordinates[1]
        return right_diagonal_equal?(symbol)
      else
        return false
      end
    end

    def right_diagonal_equal?(symbol)
      right_diagonal = []
      grid.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          right_diagonal.push(cell.content) if row_index == column_index
        end
      end

      right_diagonal.all?(symbol)
    end

    def left_diagonal_equal?(symbol)
      left_diagonal = []
      grid.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          left_diagonal.push(cell.content) if row_index + column_index == 2
        end
      end

      left_diagonal.all?(symbol)
    end

    private

    def grid
      @grid
    end

    def create_grid
      result = Array.new(3)
      3.times { |n| result[n - 1] = create_row(n - 1) }
      result
    end

    def create_row(x)
      result = Array.new(3)
      3.times { |n| result[n - 1] = Cell.new() }
      result
    end
  end

  class Cell
    attr_reader :is_filled, :content

    def initialize
      @content = "-"
      @is_filled = false
      @player_num = nil
    end

    def fill(symbol)
      @is_filled = true
      @content = symbol
    end
  end
end
