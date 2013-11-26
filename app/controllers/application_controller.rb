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
    begin
      token_header = 'X-SECURE-TOKEN'
      token = session[:secure_token]
      model_class.headers = model_class.headers.merge(token_header => token) if token
      yield
    ensure
      # ensure token always removed from headers
      model_class.headers = model_class.headers.except(token_header) if model_class.headers[token_header]
    end
  end

end
