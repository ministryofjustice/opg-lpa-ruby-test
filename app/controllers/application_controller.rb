class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_signed_in

  def create_single_date_field model_name
    if params[model_name]
      params[model_name] = MultiparameterAttributesHandler.manipulate_all params[model_name]
      params[model_name].each {|key, value| params[model_name].delete(key) if key[/\(\di\)/] }
    end
  end

  protected

  def set_signed_in
    @signed_in = read_secure_token.present?
  end

  def secure_token_cache_key
    "secure_token_#{session[:session_id]}" if session[:session_id]
  end

  def read_secure_token
    Rails.cache.read(secure_token_cache_key) if secure_token_cache_key
  end

  def with_secure_token model_class
    token_header = RackMojAuth::Resources::SECURE_TOKEN.sub('HTTP_','')

    begin
      if token = read_secure_token
        model_class.headers = model_class.headers.merge(token_header => token)
      end
      yield
    ensure
      # ensure token always removed from headers
      if model_class.headers[token_header]
        model_class.headers = model_class.headers.except(token_header)
      end
    end
  end

  def store_applicant_name applicant
    session[:applicant_name] = [applicant.first_name, applicant.last_name].join(' ')
  end
end
