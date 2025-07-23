class Api::V1::BaseController < ApplicationController
  private
  
  def render_json_success(data)
    render json: { status: 'success', data: data }
  end
  
  def render_json_error(message, status = :unprocessable_entity)
    render json: { status: 'error', message: message }, status: status
  end
end