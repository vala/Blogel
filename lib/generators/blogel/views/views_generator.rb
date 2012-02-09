module Blogel
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../../app/views", __FILE__)
    # What's that generator ?
    desc "Blogel views copy generator"
    
    def welcome
      say "[ Blogel ] Proceding to views copy ...", :green
    end
    
    # Check if rails admin exists
    def copy_views_directory
      directory 'blogel', 'app/views/blogel'
      say "[ Blogel ] Views directory copied to your views folder", :green
    end
  end
end