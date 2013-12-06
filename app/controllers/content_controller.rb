class ContentController < ApplicationController
  def homepage
  end

  def guidance
    guidanceFolderPath = "guidance/"
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    orderFile = File.readlines(guidanceFolderPath + "order.md")

    @sections = Hash.new
    @nav = Hash.new

    orderFile.each_with_index do |line, index|
      if !line.include? ".md" and line.include? "*"
        fileName = orderFile[index+1].strip.sub! '* ', ''
        id = line.sub('* ', '').gsub(' ', '-').strip.downcase!

        @sections[id] = markdown.render(File.read(guidanceFolderPath + fileName))
        @nav[id] = line.sub('* ', '').strip!
      end
    end

    render :layout => !request.xhr?
  end
end