require 'blogel/engine/routes'
# require File.expand_path '../engine/routes', __FILE__

module Blogel
  class Engine < ::Rails::Engine
    # On boot
    initializer 'blogel_boot_engine' do |app|
      Blogel.config do |config|
        # Expose app.root to engine
        config.app_root = app.root
      end
    end
  end
end

