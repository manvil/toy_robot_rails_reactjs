require 'command/base'
require 'command/direction'
module Command
  class Report < Base
    include Direction
    def move
      @report = "#{@current_x},#{@size - @current_y - 1},#{@direction.upcase}"
    end
  end
end
