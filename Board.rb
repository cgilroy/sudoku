require('byebug')

class Board

    def initialize(grid)
        @grid = grid
    end

    def self.from_file(file)
        arr = Array.new(9) { Array.new([]) }
        File.open(file, "r") do |f|
            
            f.each_line.with_index do |line,idx|
                line.chomp!
                line.each_char do |char|
                    arr[idx] << char
                end
            end
        end
    end

    def update_tile_val(pos)

    end

    def render

    end

    def solved?

    end

end

x = Board.from_file('./puzzles/sudoku1.txt')