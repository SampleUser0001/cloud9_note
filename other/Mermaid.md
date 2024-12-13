# Mermaid

- [Mermaid](#mermaid)
  - [Github PagesでMermaid記法が使えなくなっている件につい](#github-pagesでmermaid記法が使えなくなっている件につい)

## Github PagesでMermaid記法が使えなくなっている件につい

Mermaidのclassは`mermaid`なのだが、Jekyllが変換するときに`language-mermaid`に変換しているっぽい。  
回避方法を書いておく。

`_plugins/mermaid_brock.rb`

``` rb
module Jekyll
  class MermaidBlock < Liquid::Block
    def render(context)
      content = super
      "<div class=\"mermaid\">\n#{content}\n</div>"
    end
  end
end

Liquid::Template.register_tag("mermaid", Jekyll::MermaidBlock)
```

Mermaidの書き方

``` txt
{% mermaid %}
ここにMermaid記法で記載する。
{% endmermaid %}
```
