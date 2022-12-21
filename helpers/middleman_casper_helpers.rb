require 'ostruct'
require 'digest/md5'

module MiddlemanCasperHelpers
  def page_title
    # title = blog_settings.name.dup
    # if is_tag_page?
    #   title << ": #{current_resource.metadata[:locals]['tagname']}"
    # elsif current_page.data.title
    #   title << ": #{current_page.data.title}"
    # elsif is_blog_article?
    #   title << ": #{current_article.title}"
    # end
    # title
    'title'
  end

  def date_format
  end

  def page_description
    if is_blog_article?
      body = strip_tags(current_article.body).gsub(/\s+/, ' ')
      truncate(body, length: 147)
    end
  end

  def page_class
    if is_blog_article? || current_page.data.layout == 'page'
      'post-template'
    elsif current_resource.metadata[:locals]['page_number'].to_i > 1
      'archive-template'
    else
      'home-template'
    end
  end

  def summary(article)
    summary_length = article.blog_options[:summary_length]
    if article.data.subtitle
      article.data.subtitle
    else
      strip_tags(article.summary(summary_length, ''))
    end
  end

  def read_next_summary(article, words)
    body = strip_tags(article.body)
    truncate_words(body, length: words, omission: '')
  end

  def blog_author
  end

  def blog_settings
  end

  def theme(page = current_page)
    page.data.theme || 'default'
  end

  def navigation
  end

  def image_cover(page = current_page)
    if (src = page.data.cover).present?
      image_tag src, class: 'w-full'
    end
  end
  def is_tag_page?
    current_resource.metadata[:locals]['page_type'] == 'tag'
  end
  def tags?(article = current_article)
    article.tags.present?
  end
  def tags(article = current_article, separator = ', ')
    capture_haml do
      article.tags.each do |tag|
        haml_tag(:a, tag, href: tag_path(tag))
        haml_concat(separator) unless article.tags.last == tag
      end
    end.gsub("\n", '')
  end

  def current_article_url
    'somewehere'
  end

  def cover_url(page = current_page)
    # if (src = page.data.cover).present?
    #   URI.join(blog_settings.url, image_path(src)) 
    # end
  end
  def cover(page = current_page)
    if (src = page.data.cover).present?
      { style: "background-image: url(#{image_path(src)})"}
    else
      { class: 'no-cover' }
    end
  end
  def cover?(page = current_page)
    page.data.cover.present?
  end

  def gravatar_email
    'fab0670312047@gmail.com'
  end

  def gravatar(size = 68)
    md5 = Digest::MD5.hexdigest(gravatar_email)
    "https://www.gravatar.com/avatar/#{md5}?size=#{size}"
  end
  
  def gravatar?
    gravatar_email.present?
  end

  def has_translation?(page = current_page)
    page.data.translations.present?
  end

  def localized_path(path, language=nil)
    path = "/#{path}"
  end


  def twitter_url
    "https://twitter.com/share?text=#{current_article.title}" \
      "&amp;url=#{current_article_url}"
  end
  def facebook_url
    "https://www.facebook.com/sharer/sharer.php?u=#{current_article_url}"
  end
  def google_plus_url
    "https://plus.google.com/share?url=#{current_article_url}"
  end

  def feed_path
    "/feed.xml"
  end

  def home_path(language=nil)
    "/"
  end
  
  def author_path
    if I18n.locale == I18n.default_locale
      "/author/#{blog_author}/"
    else
      "/#{I18n.locale}/author/#{blog_author}/"
    end
  end
end
