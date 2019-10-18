require('colorize')
require_relative('Board')

class Game
    def initialize
        puzzle_arr = Board.from_file('./puzzles/sudoku1.txt')
        @board = Board.new(puzzle_arr)
    end

    def play
        until @board.solved?
            system('clear')
            @board.render
            input = self.prompt
            if !@board.position_okay?(input)
                puts "Invalid position"
                sleep(1)
            elsif !@board.value_okay?(input)
                puts "Invalid value"
                sleep(1)
            else
                @board.update_tile_val(input)
            end
        end
    end

    def prompt
        puts "Please enter the position to change e.g. (1,2)"
        pos = gets.chomp
        puts "Please enter the value"
        val = gets.chomp.to_i
        return {"position" => pos, "value" => val}
    end

end

x = Game.new
x.play