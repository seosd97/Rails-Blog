module PostsHelper
    require 'redcarpet'
    require 'redcarpet/render_strip'

    def parse_md_to_html(text)
        renderer = Redcarpet::Render::HTML::new({ hard_wrap: true })
        markdown = Redcarpet::Markdown::new(renderer, {})
        markdown.render(text).html_safe;
    end

    def parse_md_strip_down(text)
        markdown = Redcarpet::Markdown::new(Redcarpet::Render::StripDown)
        markdown.render(text)
    end

    def get_post_path(post)
        return is_admin_page? ? admin_post_path(post) : post_path(post)
    end
end
