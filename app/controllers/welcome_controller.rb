class WelcomeController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: 'Welcome to the simple_authentication_token sample app!', status: HTTP_OK }
      format.html { render :text => 'Welcome to the simple_authentication_token sample app!' }
     end
  end
end