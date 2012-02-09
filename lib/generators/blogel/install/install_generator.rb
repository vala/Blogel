module Blogel
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Blogel install generator"
    
    def welcome
      say "Proceding to Blogel's installation", :blue
    end
    
    # The devise check code comes from RailsAdmin install generator
    def rails_admin_check
      say "Checking if Rails Admin is present ..."

      unless defined?(RailsAdmin)
        say "Adding Rails Admin gem to your Gemfile:"
        append_file "Gemfile", "\n", :force => true
        gem 'rails_admin', :git => 'https://github.com/sferik/rails_admin.git'
      else
        say "Rails Admin already setup, continuing ..."
      end
      
      unless File.exists?(Rails.root.join("config/initializers/rails_admin.rb"))
        say "Installing Rails Admin ..."
        generate "rails_admin:install"
      else
        say "Rails Admin installed yet, continuing ..."
      end
    end
    
    def copy_initializer_file
      say "Installing initializer template"
      copy_file "initializer.rb", "config/initializers/blogel.rb"
    end
    
    def copy_migrations
      say "Installing migrations, don't forget to `rake db:migrate`"
      rake "bogel:install:migrations"
    end
    
    def mount_engine
      mount_path = ask "Where would you like to mount Blogel engine ? default : /blog"
      route "mount Blogel::Engine => '#{mount_path}', :as => 'blogel'"
    end
  end
end