module ApplicationHelper
  def markdown(text)
    unless @markdown
      renderer = Redcarpet::Render::HTML.new(
        escape_html: true,
        hard_wrap: true,
        link_attributes: { rel: 'nofollow', target: '_blank' },
        space_after_headers: true,
        fenced_code_blocks: true
      )

      @markdown = Redcarpet::Markdown.new(renderer,
        autolink: true,
        superscript: true,
        disable_indented_code_blocks: true
      )
    end

    @markdown.render(text).html_safe
  end
end
