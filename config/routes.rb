Rails.application.routes.draw do
  root :to => 'welcome#index'

  devise_for :users, :skip => [:sessions, :registrations, :passwords]
  devise_scope :user do
    post 'login' => 'sessions#create', :as => :login
    delete 'logout' => 'sessions#destroy', :as => :logout
    post 'register' => 'registrations#create', :as => :register
    delete 'delete_account' => 'registrations#destroy', :as => :delete_account
  end

  get 'greetings', to: 'greetings#index', as: 'greetings'
end
