module Jekyll
  class MermaidBlock < Liquid::Block
    def render(context)
      content = super
      "<div class=\"mermaid\">\n#{content}\n</div>"
    end
  end
end

Liquid::Template.register_tag("mermaid", Jekyll::MermaidBlock)
