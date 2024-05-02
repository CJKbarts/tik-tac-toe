module GameBoard
  class Board
    def initialize
      @grid = create_grid
    end

    def display
      for row in @grid
        for elm in row
          print elm.content
        end
        puts "\n"
      end
    end

    private

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
    attr_accessor :is_filled, :content

    def initialize
      @content = "-"
      @is_filled = false
    end
  end
end
