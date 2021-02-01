Rails.application.routes.draw do
  # properties
  scope "/" do
    # get "/properties", to: "properties#index"
    # post "/properties", to: "properties#create"
    # get "/properties/:id", to: "properties#show"
    # put "/properties/:id", to: "properties#update"
    # delete "/properties/:id", to: "properties#destroy"
    resources :properties
    # generate user_token
    scope '/auth' do
      post '/login', to: 'users#login'
      post '/sign_up', to: 'users#create'
      post '/find_user', to: 'users#find'
    end
  end
end
