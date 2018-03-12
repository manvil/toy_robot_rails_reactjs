require 'command/direction'
module Command
  class Base
    def initialize(opts)
      @size = opts[:size].to_i
      @direction = opts[:direction]
      @current_x = opts[:current_x]
      @current_y = opts[:current_y]
      @arguments = opts[:arguments]
      @command = opts[:command]
    end

    def parse
      validate!
      perform_command
    end

    def validate!
      raise ParseCommandError, 'Invalid command'
    end

    def perform_command
      raise ParseCommandError, 'Invalid command'
    end

    def info
      {
        direction: @direction.try(:downcase),
        current_x: @current_x,
        current_y: @current_y,
        report: @report
      }
    end

    def self.command(opts = {})
      raise ParseCommandError, 'Invalid command' if Command.try(:const_get, opts[:command].capitalize).blank?
      Command.const_get(opts[:command].capitalize).new(opts)
    end
  end
end
