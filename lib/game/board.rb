class Board
  include Display

  def initialize
    @grid = create_grid
  end

  def row_complete?(row_index, symbol)
    grid[row_index].all? { |cell| cell == symbol }
  end

  def column_complete?(column_index, symbol)
    column = grid.map { |row| row[column_index] }
    column.all?(symbol)
  end

  def diagonal_complete?(symbol)
    right_diagonal_complete?(symbol) || left_diagonal_complete?(symbol)
  end

  def right_diagonal_complete?(symbol)
    right_diagonal = [[0, 0], [1, 1], [2, 2]].map { |position| grid[position[0]][position[1]] }
    right_diagonal.all?(symbol)
  end

  def left_diagonal_complete?(symbol)
    left_diagonal = [[0, 2], [1, 1], [0, 2]].map { |position| grid[position[0]][position[1]] }
    left_diagonal.all?(symbol)
  end

  def clear
    initialize
  end

  def empty?(coordinates)
    return false if coordinates.empty?

    cell = cell(coordinates)
    cell.match?(/[A-I]/)
  end

  def cell(coordinates)
    @grid[coordinates[0]][coordinates[1]]
  end

  def fill(coordinates, symbol)
    @grid[coordinates[0]][coordinates[1]] = symbol
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
    (0..2).each { |column_index| result[column_index] = convert_to_letter(row_index, column_index) }
    result
  end
end
