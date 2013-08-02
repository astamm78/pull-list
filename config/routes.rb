NewPullList::Application.routes.draw do

  root to: 'home#index'
  post '/create' => 'home#create', as: 'create'
  get '/mark/:id' => 'home#mark', as: 'mark'
  get '/unmark/:id' => 'home#unmark', as: 'unmark'
  get 'reset/:id' => 'home#reset', as: 'reset'

end