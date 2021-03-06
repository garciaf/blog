###
# Blog settings
###

# Time.zone = "UTC"
activate :i18n, :mount_at_root => :fr
activate :middleman_simple_thumbnailer

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.name = "fabbook"
  blog.permalink = "post/{lang}/{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "post/{year}-{month}-{day}-{title}.html"
  blog.layout = "post"
  blog.summary_separator = /READMORE/
  blog.taglink = "tag/{tag}.html"
  # blog.summary_length = 250
  blog.year_link = "post/{year}.html"
  blog.month_link = "post/{year}/{month}.html"
  blog.day_link = "post/{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
end
set :casper, {
  blog: {
    url: 'http://fabbook.fr',
    name: 'Fabbook',
    description: 'Life and Dev',
    date_format: '%d %B %Y',
    navigation: true,
    logo: nil # Optional
  },
  author: {
    name: 'Fabien',
    bio: 'Developer by day, fighter and cook by night',
    location: 'Berlin',
    website: nil, # Optional
    gravatar_email: 'fab0670312047@gmail.com', # Optional
    twitter: 'https://twitter.com/FabbookFr'
  },
  navigation: {
    "Home" => "/",
    "English" => "/en/",
    "Français" => "/fr/"
  }
}


page '/sitemap.xml', layout: false

ignore '/partials/*'


ready do
  langs.each do |locale|
    if locale == I18n.default_locale
      proxy "/author/#{blog_author.name.parameterize}.html", "/author.#{locale}.html", ignore: true do
        ::I18n.locale = locale
      end
    else
      
      proxy "/#{locale}/author/#{blog_author.name.parameterize}.html", "/author.#{locale}.html", ignore: true do
        ::I18n.locale = locale
      end
    end
  end
end


config = YAML.load ERB.new(File.read('parameter.yml')).result(binding)

activate :deploy do |deploy|
  deploy.method = :ftp
  deploy.host = config['FTP_HOST']
  deploy.user = config['FTP_USER']
  deploy.password = config['FTP_PASSWORD']
  deploy.path = config['path']
  deploy.build_before = false # default: false
end


# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Pretty URLs - http://middlemanapp.com/basics/pretty-urls/
activate :directory_indexes

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { ugly: true }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: false

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :partials_dir, 'partials'
activate :alias
# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css
  activate :minify_html
  # Minify Javascript on build
  activate :minify_javascript
    activate :imageoptim do |options|
    options.pngout = false
    options.svgo = false
  end
  # Enable cache buster
  # activate :asset_hash
  activate :robots, :rules => [
    {:user_agent => '*', :allow => %w(/)}
  ], :sitemap => "http://fabbook.fr/sitemap.xml"
  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
