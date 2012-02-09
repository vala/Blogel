Blogel::Engine.routes.draw do
  resources :posts, :only => [:index, :show] do
    post 'comment', :action => 'comment', :as => 'comment'
  end
end
