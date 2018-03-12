require 'command/placement'
module Command
  module Direction
    def self.included(base)
      base.class_eval do
        include Placement
      end
    end

    CLOCKWISE = %w[west north east south].freeze

    def perform_command
      move
    end

    def validate!
      raise ParseCommandError, 'Invalid direction' unless valid_direction?
      raise ParseCommandError, 'Invalid placement' unless valid_placement?
      raise ParseCommandError, 'Invalid arguments' unless valid_arguments?
    end

    def valid_direction?
      @direction.present? && CLOCKWISE.include?(@direction.downcase)
    end

    def valid_arguments?
      @arguments.blank?
    end
  end
end
