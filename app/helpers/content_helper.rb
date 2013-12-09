module ContentHelper
  def compile_guidance
    guidanceFolderPath = "guidance/"
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    orderFile = File.readlines(guidanceFolderPath + "order.md")

    guidance = {:sections => {}, :nav => {}}

    orderFile.each_with_index do |line, index|
      if !line.include? ".md" and line.include? "*"
        fileName = orderFile[index+1].strip.sub '* ', ''
        title = line.sub('* ', '').strip
        id = title.gsub(' ', '-').downcase

        guidance[:sections][id] = markdown.render(File.read(guidanceFolderPath + fileName))
        guidance[:nav][id] = title
      end
    end

    guidance
  end
end