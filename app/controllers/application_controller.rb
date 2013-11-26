class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV['AUTH_NAME'], password: ENV['AUTH_PASSWORD'] if Rails.env.production?

  def create_single_date_field model_name
    if params[model_name]
      params[model_name] = MultiparameterAttributesHandler.manipulate_all params[model_name]
      params[model_name].each {|key, value| params[model_name].delete(key) if key[/\(\di\)/] }
    end
  end

  protected

  def with_secure_token model_class
    token_header = 'X-SECURE-TOKEN'

    if session[:secure_token]
      model_class.headers = model_class.headers.merge(token_header => session[:secure_token])
    end

    yield

    # model_class.headers = model_class.headers.except(token_header)
  end

end
