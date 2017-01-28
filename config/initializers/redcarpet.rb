renderer = Redcarpet::Render::HTML.new

extensions = {
  fenced_code_blocks: true,
  no_intra_emphasis: true,
  tables: true,
  lax_spacing: true,
  autolink: true
}

::Markdowner = Redcarpet::Markdown.new \
  renderer, extensions = extensions

require 'rbst'

def render_markup markup, file_name
  file_name.downcase!

  is_markdown_file = ( file_name.count('.') != 1 )
  is_markdown_file ||= ( file_name.split('.').last != 'rst' )

  return RbST.new(markup).to_html \
    unless is_markdown_file

  readme_markdown = Markdowner.render markup

  github_image_host = "#{@package.url}/master/"
  github_image_host.sub! 'github', 'raw.githubusercontent'

  readme_markdown.gsub! \
    /(?<=\<img src=")(?!http)/, github_image_host

  github_link_host = "#{@package.url}/blob/master/"

  link_sub_string = 'target="_blank" href="'
  link_sub_string += github_link_host

  readme_markdown.gsub! \
    /(?<=\<a )href="(?!http)/, link_sub_string

  readme_markdown
end
