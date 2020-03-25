# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :assignment do
    resources :todo_lists
  end
  mount Ckeditor::Engine => '/ckeditor'

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: 'blazer'
  end

  # 聊天室
  resources :room_messages
  resources :rooms

  root 'admin/lab_forums#index'

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :names, only: [:create]

      get 'ping', to: 'base#ping'
      get 'ping_auth', to: 'base#ping_auth'
      get 'info', to: 'base#info'

      resources :ideas
    end
  end

  # 履歷
  get 'resume', to: 'resume#show'

  # 版型收編
  get 'card', to: 'card#show'
  get 'testimonial', to: 'testimonial#show'

  # 基本routes應用：https://railsbook.tw/chapters/11-routes.html
  get '/:single_page', to: 'staticpages#show', as: 'page'

  devise_for :users, module: 'auth'

  namespace :admin do
    resources :lab_forums do
      resources :comments
      get 'status', on: :member

      resources :likes, only: :create
    end

    resources :question_types, except: :show
    resources :member_login_histories, only: :index
  end

  namespace :assignment do
    resources :todos do
      get 'status', on: :member
    end

    resources :items_imports, only: %i[new create] do
      get 'excel_template', on: :collection
    end
  end

  # get 'bmi', to: 'bmi#index'
  # post 'bmi', to: 'bmi#result'

  # get 'name', to: 'name#index'
  # post 'name', to: 'name#post_result'
  # get 'username', to: 'name#get_result'
end
