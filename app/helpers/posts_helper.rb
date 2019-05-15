module PostsHelper
    def md_to_html(text)
        renderer = Redcarpet::Render::HTML::new(option = {})
        markdown = Redcarpet::Markdown::new(renderer, extension = {})
        markdown.render(text).html_safe;
    end
end
