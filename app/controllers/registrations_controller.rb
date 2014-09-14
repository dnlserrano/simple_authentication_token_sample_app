class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_filter :verify_authenticity_token, if: :json_request?

  acts_as_token_authentication_handler_for User
  skip_before_filter :authenticate_entity_from_token!, only: [:create]
  skip_before_filter :authenticate_entity!, only: [:create]

  skip_before_filter :authenticate_scope!
  append_before_filter :authenticate_scope!, only: [:destroy]

  def create
    build_resource(sign_up_params)
    if resource.save!
      status = HTTP_OK
      message = "Successfully created new account for email #{sign_up_params[:email]}."
    else
      clean_up_passwords resource
      status = HTTP_INTERNAL_SERVER_ERROR
      message = "Failed to create new account for email #{sign_up_params[:email]}."
    end

    respond_to do |format|
      format.json {
        render json: {
          message: message
        }, status: status
      }
    end
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)

    respond_to do |format|
      format.json {
        render json: {
          message: 'Successfully deleted the account.'
        }, status: HTTP_OK
      }
    end
  end

  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def json_request?
    request.format.json?
  end
end