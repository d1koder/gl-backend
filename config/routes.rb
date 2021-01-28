Rails.application.routes.draw do
  scope "/" do
    get "/properties", to: "properties#index"
    post "/properties", to: "properties#create"
    get "/properties/:id", to: "properties#show"
    put "/properties/:id", to: "properties#update"
    delete "/properties/:id", to: "properties#destroy"
    # use 'users' instead of 'auth' for now
    scope "/users" do
      post '/sign_up', to: 'users#create'
      post '/login', to: 'users#login'
    end
  end
end
