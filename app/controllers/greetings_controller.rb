class GreetingsController < ApiController
  def index
    respond_to do |format|
      format.json { render json: 'Hello! Congrats, your authentication was successful! :)', status: HTTP_OK }
     end
  end
end