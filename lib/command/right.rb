require 'command/base'
module Command
  class Right < Base
    include Direction
    def move
      @direction = CLOCKWISE[(CLOCKWISE.index(@direction.downcase) + 1) % CLOCKWISE.length]
    end
  end
end
