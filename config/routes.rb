Rails.application.routes.draw do

  root to: 'coffee#search', as: :search
  post '/coffee' => 'coffee#results', as: :coffee

  namespace :api do
    get '/coffee' => 'coffee#results'
  end

end
