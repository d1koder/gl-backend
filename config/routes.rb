Rails.application.routes.draw do
  scope "/api" do
    get "/properties", to: "properties#index"
    post "/properties", to: "properties#create"
    get "/properties/:id", to: "properties#show"
    put "/properties/:id", to: "properties#update"
    delete "/properties/:id", to: "properties#destroy"
    scope "/auth" do
      post '/sign_up', to: 'users#create'
    end
  end
end
