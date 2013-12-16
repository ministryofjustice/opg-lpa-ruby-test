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
        guidance[:sections][id] = markdown.render(File.read(guidanceFolderPath + fileName)).gsub /<a href="\/help\/#topic-(.+)">(.+)<\/a>/, '<a href="/help/#topic-\1" class="js-guidance" data-journey="stageprompt.lpa:help:\1">\2</a>'
        guidance[:nav][id] = title
      end
    end

    guidance
  end

  def guidance_link (label, section_id)
    link_to label, "#{help_path}/#topic-#{section_id}", {:class => 'js-guidance', "data-journey-click" => "stageprompt.lpa:help:#{section_id}" }
  end
end
