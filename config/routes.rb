Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: 'blazer'
  end

  # 聊天室
  resources :room_messages
  resources :rooms

  root 'admin/lab_forum#index'

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :names, only: [:create]

      get 'ping', to: 'base#ping'
      get 'ping_auth', to: 'base#ping_auth'
      get 'info', to: 'base#info'
    end
  end

  # 履歷
  get 'resume', to: 'resume#show'

  # 版型收編
  get 'card', to: 'card#show'

  # 基本routes應用：https://railsbook.tw/chapters/11-routes.html
  get '/:single_page', to: 'staticpages#show', as: 'page'

  scope '(:locale)', locale: /en|zh-TW/ do
    devise_for :users, module: 'auth'

    # 慣例：名字後須 +s
    scope module: 'admin' do
      resources :lab_forum do
        resources :comments
        get 'status', on: :member

        resources :likes, only: [:create]
      end
    end

    root 'lab_forum#index'

    scope module: 'assignment' do
      # resources :todolists do
      #   get 'status', on: :member
      # end

      # https://stackoverflow.com/questions/19189415/how-may-two-routes-with-different-http-request-types-share-the-same-name
      get '/todolists/:id/status', to: 'todolists#status', as: 'status_todolist'
      get  '/todolists', to: 'todolists#index', as: 'todolists'
      post '/todolists', to: 'todolists#create'
      get  '/todolists/new', to: 'todolists#new', as: 'new_todolist'
      get  '/todolists/:id/edit', to: 'todolists#edit', as: 'edit_todolist'
      get  '/todolists/:id', to: 'todolists#show', as: 'todolist'
      patch '/todolists/:id', to: 'todolists#update'
      delete '/todolists/:id', to: 'todolists#destroy'

      root 'todolists#index', to: ''
    end

    # constraints subdomain: 'admin' do
    #   scope module: 'admin' do
    #     resources :lab_forum do
    #       resources :comments
    #       get 'status', on: :member
    #     end
    #     root 'lab_forum#index'
    #   end
    # end

    # constraints subdomain: 'assignment' do
    #   scope module: 'assignment' do
    #     resources :todolists
    #     root 'todolists#index'
    #   end
    # end

    # 高見龍老師的範例
    get 'bmi', to: 'bmi#index'
    post 'bmi', to: 'bmi#result'

    # get, post自己寫
    get 'name', to: 'name#index'
    post 'name', to: 'name#post_result'
    get 'username', to: 'name#get_result'
  end
end
