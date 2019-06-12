module PostsHelper
    require 'redcarpet'
    require 'redcarpet/render_strip'

    def parse_md_to_html(text)
        options = {
            hard_wrap: true
        }

        extensions = {
            fenced_code_blocks: true
        }

        renderer = Redcarpet::Render::HTML::new(options)
        markdown = Redcarpet::Markdown::new(renderer, extensions)
        markdown.render(text).html_safe;
    end

    # Text Token을 제외한 순수 텍스트만 파싱
    def parse_md_strip_down(text)
        markdown = Redcarpet::Markdown::new(Redcarpet::Render::StripDown)
        markdown.render(text)
    end

    def get_post_path(post)
        return is_admin_page? ? admin_post_path(post) : post_path(post)
    end
end
