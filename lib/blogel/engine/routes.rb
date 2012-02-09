module ActionDispatch::Routing
  class Mapper
    def blogel_at(mount_location)
      scope mount_location, :module => 'blogel' do
        resources :posts, :only => [:index, :show] do
          post 'comment', :action => 'comment', :as => 'comment'
        end
        root :to => 'posts#index'
      end
    end
  end
end

