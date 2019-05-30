module PostsHelper
    def md_to_html(text)
        renderer = Redcarpet::Render::HTML::new(option = {})
        markdown = Redcarpet::Markdown::new(renderer, extension = {})
        markdown.render(text).html_safe;
    end

    def get_post_path(post)
        return is_admin_page? ? admin_post_path(post) : post_path(post)
    end
end
