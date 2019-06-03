module PostsHelper
    def md_to_html(text)
        renderer = Redcarpet::Render::HTML::new({ hard_wrap: true })
        markdown = Redcarpet::Markdown::new(renderer, {})
        markdown.render(text).html_safe;
    end

    def get_post_path(post)
        return is_admin_page? ? admin_post_path(post) : post_path(post)
    end
end
