xml.instruct!
xml.rss version: '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title 'NewsArticles'
    xml.description 'Description'
    xml.link root_url
    xml.language 'ru'
    xml.tag! 'atom:link', rel: 'self', type: 'application/rss+xml', href: 'home/rss'

    for article in @news_articles
      xml.item do
        xml.title article.title
        xml.link news_article_url(article)
        xml.pubDate(article.created_at.rfc2822)
        xml.guid news_article_url(article)
        xml.description(h(article.description))
      end
    end

  end

end
