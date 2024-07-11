class Board
  include Display

  def initialize
    @grid = create_grid
  end

  def fill_cell(coordinates, symbol)
    x_coord = coordinates[0]
    y_coord = coordinates[1]
    @grid[x_coord][y_coord].fill(symbol)
  end

  def get_cell(row_index, column_index)
    @grid[row_index][column_index]
  end

  def row_equal?(row_index, symbol)
    grid[row_index].all? { |cell| cell.content == symbol }
  end

  def column_equal?(column_index, symbol)
    column = grid.map { |row| row[column_index].content }
    column.all?(symbol)
  end

  def diagonal_equal?(coordinates, symbol)
    if coordinates[0] == coordinates[1] && coordinates[0] + coordinates[1] == 2
      right_diagonal_equal?(symbol) || left_diagonal_equal?(symbol)
    elsif coordinates[0] + coordinates[1] == 2
      left_diagonal_equal?(symbol)
    elsif coordinates[0] == coordinates[1]
      right_diagonal_equal?(symbol)
    else
      false
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

  def clear
    grid.each_with_index do |row, row_index|
      row.each_with_index { |cell, cell_index| cell.reset(row_index, cell_index) }
    end
  end

  private

  attr_reader :grid

  def create_grid
    result = Array.new(3)
    for i in 0..2
      result[i] = create_row(i)
    end

    result
  end

  def create_row(row_index)
    result = Array.new(3)
    for j in 0..2
      result[j] = Cell.new(row_index, j)
    end

    result
  end
end
