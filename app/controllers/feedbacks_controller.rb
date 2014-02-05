class FeedbacksController < ApplicationController
  protect_from_forgery

  def index
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.valid?
      params["service"] = request.host
      params["browser"] = request.env['HTTP_USER_AGENT']
      params["ip"] = request.env["HTTP_X_FORWARDED_FOR"]
      NotificationsMailer.new_message(params).deliver
      redirect_to feedback_path
    else
      render "new"
    end
  end

  def show
  end
end
