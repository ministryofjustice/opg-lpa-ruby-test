class ContentController < ApplicationController
  def homepage
  end

  def guidance
    render :layout => !request.xhr?
  end
end