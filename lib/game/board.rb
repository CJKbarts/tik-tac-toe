class Board
  include Display

  def initialize
    @grid = create_grid
  end

  def get_cell(string)
    coordinates = convert_to_coordinates(string)
    @grid[coordinates[0]][coordinates[1]]
  end

  def row_complete?(row_index, symbol)
    grid[row_index].all? { |cell| cell.content == symbol }
  end

  def column_complete?(column_index, symbol)
    column = grid.map { |row| row[column_index].content }
    column.all?(symbol)
  end

  def diagonal_complete?(coordinates, symbol)
    if coordinates[0] == coordinates[1] && coordinates[0] + coordinates[1] == 2
      right_diagonal_complete?(symbol) || left_diagonal_complete?(symbol)
    elsif coordinates[0] + coordinates[1] == 2
      left_diagonal_complete?(symbol)
    elsif coordinates[0] == coordinates[1]
      right_diagonal_complete?(symbol)
    else
      false
    end
  end

  def right_diagonal_complete?(symbol)
    right_diagonal = []
    grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        right_diagonal.push(cell.content) if row_index == column_index
      end
    end

    right_diagonal.all?(symbol)
  end

  def left_diagonal_complete?(symbol)
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

  def empty?(cell)
    return false if cell == ''

    !cell.is_filled
  end

  private

  attr_reader :grid

  def create_grid
    result = Array.new(3)
    (0..2).each { |row_index| result[row_index] = create_row(row_index) }
    result
  end

  def create_row(row_index)
    result = Array.new(3)
    (0..2).each { |column_index| result[column_index] = Cell.new(row_index, column_index) }
    result
  end

  def convert_to_coordinates(cell)
    coordinates = CELL_CONTENTS.key(cell)
    [coordinates[0].to_i, coordinates[1].to_i]
  end
end
