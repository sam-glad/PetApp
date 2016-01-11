class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  # protect_from_forgery with:(:null_session)
  def default_serializer_options
    { root: false }
  end
end
