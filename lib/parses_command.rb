require 'parse_command_error'
class ParsesCommand
  Result = Struct.new(:success?, :result)
  attr_reader :size, :direction, :current_x, :current_y, :command
  def initialize(opts = {})
    @opts = opts.merge(
      command: opts[:command].split(/[ ]+/, 2)[0].try(:downcase).try(:strip),
      arguments:  opts[:command].split(/[ ]+/, 2)[1].try(:downcase).try(:strip)
    )
  end

  def parse
    require "command/#{@opts[:command]}"
    command = Command::Base.command(@opts)
    command.parse
    Result.new(true, command.info)
  rescue LoadError
    Result.new(false, error: 'Invalid command')
  rescue ParseCommandError => e
    Result.new(false, error: e.message)
  end
end
