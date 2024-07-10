class Cell
  attr_reader :is_filled, :content

  def initialize(row_num, column_num)
    @content = row_num.to_s + column_num.to_s
    @is_filled = false
    @player_num = nil
  end

  def fill(symbol)
    @is_filled = true
    @content = symbol
  end

  def reset(row_index, column_index)
    initialize(row_index, column_index)
  end
end
