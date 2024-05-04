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

    def fill_cell(coordinates, player_num)
      x_coord = coordinates[0]
      y_coord = coordinates[1]
      @grid[x_coord][y_coord].fill(player_num)
    end

    def get_cell(x, y)
      @grid[x][y]
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
    attr_reader :is_filled, :content

    def initialize
      @content = "-"
      @is_filled = false
    end

    def fill(player_num)
      @is_filled = true
      @content = (player_num == 1) ? "X" : "O"
    end
  end
end
