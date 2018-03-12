require 'parses_command'
class CommandsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    result = ParsesCommand.new(create_params).parse
    if result.success?
      render json: result.result
    else
      render json: result.result, status: :bad_request
    end
  end

  private

  def create_params
    params.require(:command).permit(:command, :current_x, :current_y, :direction, :size)
  end
end
