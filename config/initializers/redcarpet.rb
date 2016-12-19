renderer = Redcarpet::Render::HTML.new
extensions = {}

::Markdowner = Redcarpet::Markdown.new \
  renderer, extensions = extensions

require 'rbst'

def render_markup markup, file_name
  file_name.downcase!

  is_markdown_file = ( file_name.count('.') != 1 )
  is_markdown_file ||= ( file_name.split('.').last != 'rst' )

  return Markdowner.render markup \
    if is_markdown_file

  RbST.new(markup).to_html
end
