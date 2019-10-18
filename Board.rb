require('byebug')
require_relative('Tile')

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
                    if char != '0'
                        arr[idx] << Tile.new(char.to_i,true)
                    else
                        arr[idx] << Tile.new(char.to_i,false)
                    end
                end
            end
        end
        arr
    end

    def update_tile_val(pos)

    end

    def render
        @grid.each_with_index do |row,idx|
            row.each_with_index do |tile,idx|
                # debugger
                if (idx+1) % 3 == 0 && idx != 8
                    print tile.value.to_s + "|"
                else
                    print tile.value.to_s + " "
                end
            end
            if (idx+1) % 3 == 0 && idx != 8
                puts
                17.times do
                    print "-"
                end
            end
            puts
        end
    end

    def solved?

    end

end

x = Board.from_file('./puzzles/sudoku1.txt')
y = Board.new(x)
y.render