class Cell
  include Display
  attr_reader :is_filled, :content, :row, :column

  def initialize(row_index, column_index)
    @content = CELL_CONTENTS[row_index.to_s + column_index.to_s]
    @is_filled = false
    @player_num = nil
    @row = row_index
    @column = column_index
  end

  def fill(symbol)
    @is_filled = true
    @content = symbol
  end

  def reset(row_index, column_index)
    initialize(row_index, column_index)
  end
end
