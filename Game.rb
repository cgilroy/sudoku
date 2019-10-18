require_relative('Board')

class Game
    def initialize
        puzzle_arr = Board.from_file('./puzzles/sudoku1_solved.txt')
        @board = Board.new(puzzle_arr)
    end

    def play
        until @board.solved?

        end
    end

end

x = Game.new
x.play