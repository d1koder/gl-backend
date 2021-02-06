Rails.application.routes.draw do
  # properties
  scope "/api" do
    # get "/properties", to: "properties#index"
    # post "/properties", to: "properties#create"
    # get "/properties/:id", to: "properties#show"
    # put "/properties/:id", to: "properties#update"
    # delete "/properties/:id", to: "properties#destroy"
    resources :properties
    resources :bookings
    resources :charges
    # generate user_token
    scope '/auth' do
      post '/login', to: 'users#login'
      post '/sign_up', to: 'users#create'
      post '/find_user', to: 'users#find'
    end
  end
end
