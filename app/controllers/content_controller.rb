class ContentController < ApplicationController
  def homepage
  end

  def guidance
    guidance = view_context.compile_guidance

    @sections = guidance[:sections]
    @nav = guidance[:nav]

    render :layout => !request.xhr?
  end
end