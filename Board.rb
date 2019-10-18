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

    def update_tile_val(input)
        pos_arr = input["position"].split('')
        @grid[pos_arr[0].to_i-1][pos_arr[2].to_i-1].value = input["value"]
    end

    def position_okay?(input)
        pos = input["position"]
        pos_arr = pos.split('')
        return false if pos.length != 3
        return false if pos_arr[1] != ","
        return false if @grid[pos_arr[0].to_i-1][pos_arr[2].to_i-1].is_given
        return false if !(0..8).include?(pos_arr[0].to_i-1) || !(0..8).include?(pos_arr[2].to_i-1)
        true
    end

    def value_okay?(input)
        return false if !(1..9).include?(input["value"])
        true
    end

    def render
        @grid.each_with_index do |row,idx|
            row.each_with_index do |tile,idx|
                # debugger
                if (idx+1) % 3 == 0 && idx != 8
                    if tile.is_given
                        print tile.value.to_s + "|"
                    else
                        print tile.value.to_s.colorize(:color => :black,:background => :white) + "|"
                    end
                else
                    if tile.is_given
                        print tile.value.to_s + " "
                    else
                        print tile.value.to_s.colorize(:color => :black,:background => :white) + " "
                    end
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
        return true if row_sum_correct? && col_sum_correct? && grid_sum_correct?
        false
    end

    def row_sum_correct?
        @grid.each_with_index do |row,row_idx|
            row_sum = row.inject(0){|sum,x| sum + x.value.to_i }
            return false if row_sum != 45
        end
        true
    end

    def col_sum_correct?
        (0..8).each do |col|
            col_sum = 0
            (0..8).each do |row|
                col_sum += @grid[row][col].value.to_i
            end
            return false if col_sum != 45
        end
        true
    end

    def grid_sum_correct?
        [0,3,6].each do |row_step|
            [0,3,6].each do |col_step|
                start_corner = [row_step,col_step]
                return false if sum_grid(start_corner) != 45
            end
        end
        true
    end

    def sum_grid(start_corner)
        start_row = start_corner[0]
        start_col = start_corner[1]
        grid_sum = 0
        (start_row..start_row+2).each do |row|
            (start_col..start_col+2).each do |col|
                grid_sum += @grid[row][col].value
            end
        end
        grid_sum
    end

end