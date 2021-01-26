Rails.application.routes.draw do
  post "/properties", to: "properties#create"
  get "/properties", to: "properties#index"
end
