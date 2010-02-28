#!/usr/bin/ruby
img_dir = "public/images/**/*"
css_dir = "public/stylesheets/**/*"
js_dir = "public/javascripts/**/*"
views_dir = "app/views/**/*"

# Grab all images
imgs = Dir.glob(img_dir).collect

# Grab all Stylesheets
css = Dir.glob(css_dir).select{ |f| f =~ /.css$/ } 

# Grab all Views
views = Dir.glob(views_dir).select{ |f| f =~ /.html.erb$/ } 

# Grab all JS
js = Dir.glob(js_dir).select{ |f| f =~ /.js$/ } 

def grep_in(s,i,t)
  s.each do |file| 
    File.readlines(file).each { |l| l.grep(/#{i}/).each { |r| t << i; return t } }
  end
end

file_name = "image_audit.txt"
file = File.new(file_name, "w")

imgs.each do |img|
  sub_img = img.split("/").last
  tracker = []
  [css,views,js].each do |s| 
    grep_in(s,sub_img,tracker) 
  end  
  if tracker.empty?
    file.puts(img) 
    puts img
    # system("svn rm #{img}")
  end
end
