require 'command/base'
module Command
  class Place < Base
    include Direction
    def valid_placement?
      true
    end

    def valid_direction?
      true
    end

    def valid_arguments?
      return false if @arguments.blank?
      @info = @arguments.downcase.split(/[ ]*,[ ]*/)
      return false unless @info.length == 3
      new_x, new_y, new_direction = @info
      valid?(new_x, new_y, new_direction)
    end

    def move
      @current_x, @current_y, @direction = @info
      @current_x = @current_x.to_i
      @current_y = @size - @current_y.to_i - 1
    end

    def valid?(x, y, f)
      return false unless CLOCKWISE.include?(f)
      valid_numbers?(x, y)
    end
  end
end
