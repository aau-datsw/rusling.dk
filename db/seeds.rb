require 'redcarpet'

def html_parse(input, parser)
  if (parser == "textile")
    RedCloth.new(input).to_html
  elsif (parser == "markdown")
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(input)
  else
    raise "Parser not supported, please try again (markdown/textile)"
  end
end

Dir[File.join(Rails.root, 'db', 'seeds', 'setup_*.rb')].sort.each do |seed|
  load seed
end

if Rails.env.production?
  #Create Frontpage
  #create_frontpage('rusling.dk')

  #Create domains
  create_datsw('datsw.rusling.dk')
  create_baitixdinf('bait-ixd-inf.rusling.dk')
end

if Rails.env.development?
#Forside
  create_frontpage('localhost')

#Domæner
  create_baitixdinf('bait-ixd-inf.localhost')
  create_datsw('datsw.localhost')

end
