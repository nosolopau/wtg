Rails.application.routes.draw do
  devise_for :admins

  resources :scans, only: [:new, :create, :show, :index] do
    member do
      get 'reprocess'
    end
  end

  namespace :admin do
    resources :scans
  end

  root :to => "home#index"
end
