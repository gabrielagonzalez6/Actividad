Rails.application.routes.draw do
  
  resources :reportes
  root 'home#index'

   get  "dropbox/main"
   post "dropbox/upload"
   get  "dropbox/auth_start"
   get  "dropbox/auth_finish"

   post 'reportes/upload_file'

  devise_for :models
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
