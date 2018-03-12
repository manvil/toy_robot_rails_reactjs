require 'command/base'
module Command
  class Left < Base
    include Direction
    def move
      @direction = CLOCKWISE[CLOCKWISE.index(@direction.downcase) - 1]
    end
  end
end
