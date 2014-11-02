Rails.application.routes.draw do
  resources :scans, only: [:new, :create, :show, :index] do
    member do
      get 'reprocess'
    end
  end

  root to: 'home#index'

  devise_for :admins

  get '/admin', to: redirect('/admin/scans')
  namespace :admin do
    resources :scans,  only: [:show, :index, :destroy]
  end
end
