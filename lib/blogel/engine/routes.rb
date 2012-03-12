module ActionDispatch::Routing
  class Mapper
    def blogel_at(mount_location)
      scope mount_location, :module => 'blogel' do
        resources :posts, :only => [:index, :show] do
          collection do
            get 'search', :action => 'search', :as => 'search'
            get 'filter/:category', :action => 'filter', :as => 'filter'
            get 'tags/:tag_id', :action => 'filter_by_tag', :as => 'tagged'
          end
          member do
            post 'comment', :action => 'comment', :as => 'comment'
          end
        end
        resources :tags, :only => [:index]
        root :to => 'posts#index'
      end
    end
  end
end

