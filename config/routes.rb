NewPullList::Application.routes.draw do

  root to: 'home#index'
  post 'create', to: 'home#create', as: 'create'
  get 'mark/:id', to:'home#mark', as: 'mark'
  get 'unmark/:id', to: 'home#unmark', as: 'unmark'
  get 'reset/:id', to: 'home#reset', as: 'reset'
  get 'unfollow/:title', to: 'home#unfollow', as: 'unfollow'

end