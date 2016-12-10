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

  def navbar_links
    {
      questions: {
        uri: questions_path,
        active: controller_name == 'questions',
      },
      quiz: {
        uri: quiz_index_path,
        active: controller_name == 'quiz' && action_name != 'random'
      },
      random: {
        uri: random_quiz_index_path,
        active: controller_name == 'quiz' && action_name == 'random'
      }
    }
  end
end
