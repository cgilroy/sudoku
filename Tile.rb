class Tile
    attr_accessor :value
    attr_reader :is_given
    def initialize(value,is_given)
        @value = value
        @is_given = is_given
    end

    
end