class ApiController < ApplicationController
  # define which model will act as token authenticatable
  acts_as_token_authentication_handler_for User

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  respond_to :json
  skip_before_filter :verify_authenticity_token, if: :json_request?

  private

  def json_request?
    request.format.json?
  end
end