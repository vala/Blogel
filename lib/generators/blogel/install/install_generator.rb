require File.expand_path('../utils', __FILE__)

module Blogel
  class InstallGenerator < Rails::Generators::Base
    include Generators::Utils::InstanceMethods
    source_root File.expand_path('../templates', __FILE__)
    desc "Blogel install generator"
    
    def welcome
      do_say "Proceding to Blogel's installation", :green
    end
    
    # The devise check code comes from RailsAdmin install generator
    def rails_admin_check
      do_say "Checking if Rails Admin is present ..."

      unless defined?(RailsAdmin)
        do_say "Adding Rails Admin gem to your Gemfile:"
        append_file "Gemfile", "\n", :force => true
        gem 'rails_admin', :git => 'https://github.com/sferik/rails_admin.git'
      else
        do_say "Rails Admin already setup, continuing ..."
      end
      
      unless File.exists?(Rails.root.join("config/initializers/rails_admin.rb"))
        do_say "Installing Rails Admin ..."
        generate "rails_admin:install"
      else
        do_say "Rails Admin installed yet, continuing ..."
      end
    end
    
    def copy_initializer_file
      do_say "Installing initializer template"
      copy_file "initializer.rb", "config/initializers/blogel.rb"
    end
    
    def copy_migrations
      do_say "Installing migrations, don't forget to `rake db:migrate`"
      rake "blogel:install:migrations"
    end
    
    def mount_engine
      mount_path = ask("Where would you like to mount Blogel engine ? [/blog]").presence || '/blog'
      gsub_file "config/routes.rb", /mount Blogel::Engine => \'\/?.*\', :as => \'blogel\'/, ''
      route "mount Blogel::Engine => '#{mount_path.match(/^\//) ? mount_path : "/#{mount_path}"}', :as => 'blogel'"
    end
  end
end