Rails.application.routes.draw do
  
  root 'posts#index'
  get 'homepage' => 'homepage#index'
  get 'posts/mypage' => 'posts#mypage'
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments
  end
  resources :answers, :except => [:new]
  resources :reactions, :except => [:new]
  get 'posts' => 'posts#index'
  get 'answers/new/:postId' => 'answers#new'
  get 'reactions/new/:answerId' => 'reactions#new'

  devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end