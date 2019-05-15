class ApplicationController < ActionController::Base
    
    def md_to_html(text)
        renderer = Redcarpet::Render::HTML::new()
        markdown = Redcarpet::Markdown::new(renderer)
        markdown.render(text);
    end
end
