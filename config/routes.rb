Rails.application.routes.draw do

  resources :read_files
  root 'home#index'

   get  "dropbox/main"
   post "dropbox/upload"
   get  "dropbox/auth_start"
   get  "dropbox/auth_finish"

   post 'read_files/upload_file'
   get 'report/filter'

   #post 'report/get_params'
   # post 'report/index'

   match 'report/get_params' => 'report#get_params', via: [:get, :post]

  devise_for :models
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
