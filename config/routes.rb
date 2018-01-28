Rails.application.routes.draw do

  #root is set to display blog posts
  root to: 'web_pages#index', tag_id: "1"
  
  #locales
  get '/en' => 'web_pages#index', tag_id: "1", locale: "en"
  get '/cs' => 'web_pages#index', tag_id: "1", locale: "cs"

  # web pages
  post '/web_pages/update_content' => 'web_pages#update_content'
  post '/web_pages/edit_page_image/:id' => 'web_pages#edit_page_image'
  get '/web_pages/admin_index' => 'web_pages#admin_index'
  get '/web_pages/index(/:tag_id)' => 'web_pages#index'
  get '/web_pages/new(/:tag_id)' => 'web_pages#new'
  get '/web_pages/publish/:id' => 'web_pages#publish'
  resources :web_pages
  
  # dynamic menus
  post '/dynamic_menus/replace_by_menu_title' => 'dynamic_menus#replace_by_menu_title'
  resources :dynamic_menus, :only => [:edit]

  # images
  get '/images/all_image_links(/:album_id)' => 'images#all_image_links'
  post '/images/:album_id' => 'images#create'
  resources :images, :only => [:create, :destroy]
  
  # media manager
  resources :media_manager, :except => [:show]
  get '/media_manager/:album' => 'media_manager#album_contents'

  # sessions
  controller :sessions do
    get 'rule-me' => :new
    post 'rule-me' => :create
    delete 'sign-out' => :destroy
  end
  
  # business intelligence
  get '/analytics/settings' => 'analytics#settings'
  post '/analytics/update_settings' => 'analytics#update_settings'
  patch '/analytics/update_settings' => 'analytics#update_settings'
  resources :analytics, :only => [:index]
  
  # fallback for pretty web page urls
  get "*path" => "web_pages#show"

end