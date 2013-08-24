namespace :rsync do
  desc "--dry-run rsync"
    task :dryrun do
      system('jekyll build')
      system('rsync _site/ -ave ssh --dry-run --delete vagrant@192.168.33.10:/home/vagrant/deploy/')
    end
  desc "rsync"
    task :live do
      system('jekyll build')
      system('rsync _site/ -ave ssh --delete vagrant@192.168.33.10:/home/vagrant/deploy/')
    end
end
# Usage:
# rake write["Post Title Goes Here",category]
desc "Given a title as an argument, create a new post file"
task :write, [:title, :category] do |t, args|
  puts args
  puts t
  filename = "#{Time.now.strftime('%Y-%m-%d')}-#{args.title.gsub(/\s/, '_').downcase}.markdown"
  path = File.join("_posts", filename)
  if File.exist? path; raise RuntimeError.new("Won't clobber #{path}"); end
  File.open(path, 'w') do |file|
    file.write <<-EOS
---
layout: post
category: #{args.category}
title: #{args.title}
date: #{Time.now.strftime('%Y-%m-%d %k:%M:%S')}
subtitle: Subtitle
published: false
---
EOS
    end
    puts "Now open #{path} in an editor."
end

desc 'Running Jekyll serve with --watch opition'
task :dev do
  system('jekyll serve --watch')
end