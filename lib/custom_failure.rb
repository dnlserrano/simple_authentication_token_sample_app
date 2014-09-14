class CustomFailure < Devise::FailureApp
  def redirect_url
    root_path
  end

  def respond
    if http_auth?
      http_auth
    else
      if request.format.json?
        self.status = HTTP_UNAUTHORIZED
        self.response_body = 'Login failed.'
        self.content_type = 'json'
      else
        redirect
      end
    end
  end
end