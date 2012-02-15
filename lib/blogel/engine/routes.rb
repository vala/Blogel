module ActionDispatch::Routing
  class Mapper
    def blogel_at(mount_location)
      scope mount_location, :module => 'blogel' do
        resources :posts, :only => [:index, :show] do
          collection do
            get 'search', :action => 'search', :as => 'search'
            get 'filter/:category', :action => 'filter', :as => 'filter'
          end
          member do
            post 'comment', :action => 'comment', :as => 'comment'
          end
        end
        root :to => 'posts#index'
      end
    end
  end
end

