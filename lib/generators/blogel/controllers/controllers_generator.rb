module Blogel
  class ControllersGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../../app/controllers", __FILE__)
    # What's that generator ?
    desc "Blogel controllers copy generator"

    def welcome
      say "[ Blogel ] Proceding to controllers copy ...", :green
    end

    # Check if rails admin exists
    def copy_controllers_directory
      directory 'blogel', 'app/controllers/blogel'
      say "[ Blogel ] Controllers directory copied to your controllers folder", :green
    end
  end
end