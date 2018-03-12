require 'command/base'
module Command
  class Move < Base
    include Direction
    def move
      case @direction.downcase
      when 'west'
        move_west
      when 'north'
        move_north
      when 'east'
        move_east
      when 'south'
        move_south
      end
    end

    def move_west
      @current_x -= 1 if @current_x.positive?
    end

    def move_north
      @current_y -= 1 if @current_y.positive?
    end

    def move_east
      @current_x += 1 if @current_x < @size - 1
    end

    def move_south
      @current_y += 1 if @current_y < @size - 1
    end
  end
end
