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

  escaped_identifier = "julia-observer-quote-cut-paste"

  escaped_markup_blocks = markup.scan /(?<!`)`[^\`]+`/

  escaped_markup_blocks.each_with_index do |escaped_markup, index|
    markup.sub! \
      escaped_markup,
      "`#{escaped_identifier}-#{index}`"
  end

  escaped_markup_blocks.map! { |m| CGI.escapeHTML m }

  rendered_markdown = ( markup.include? "``` html" ) ? \
    render_markdown_with_html_code_blocks(markup) : \
    render_markdown_markup(markup)

  escaped_markup_blocks.each_with_index do |escaped_markup, index|
    rendered_markdown.sub! \
      "#{escaped_identifier}-#{index}", \
      escaped_markup[1..-2]
  end

  rendered_markdown
end

def render_markdown_markup markup
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

  readme_markdown.gsub! \
    (/(href=\\&quot;)([^\\]*)(\\&quot;)/) \
    { "href=\"#{$2}\" target=\"_blank\"" }

  CGI.unescapeHTML readme_markdown
end

def render_markdown_with_html_code_blocks markup
  escaped_identifier = "julia-observer-html-cut-paste"

  split_markup_blocks = markup.split "``` html"

  escaped_markup_blocks = []

  split_markup_blocks.each_with_index do |markup_block, index|
    next if index.zero?

    escaped_markup, unescaped_markup = \
      markup_block.split "```", 2

    escaped_markup_blocks << escaped_markup
    split_markup_blocks[index] = unescaped_markup
  end

  escaped_markup_blocks.map! { |m| CGI.escapeHTML m }

  escaped_filler = \
    [*0..escaped_markup_blocks.length].map { |i|
      "``` html\n#{escaped_identifier}-#{i}\n```"
    }

  work_markdown = split_markup_blocks
    .zip(escaped_filler).flatten.join

  work_markdown = render_markdown_markup work_markdown

  escaped_markup_blocks.each_with_index do |escaped_markup, index|
    work_markdown.sub! \
      "#{escaped_identifier}-#{index}", \
      escaped_markup.strip
  end

  work_markdown
end
