Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  # namespace :admin do
  #   resources :lab_forum do
  #     resources :comments
  #     get 'status', on: :member
  #   end
  #   root 'lab_forum#index'
  # end

  # namespace :assignment do
  #   get 'todos/index'
  #   get 'todos/new'
  #   get 'todos/show'
  # end

  constraints subdomain: 'admin' do
    scope module: 'admin' do
      resources :lab_forum do
        resources :comments
        get 'status', on: :member
      end
      root 'lab_forum#index'
    end
  end

  constraints subdomain: 'assignment' do
    scope module: 'assignment' do
      resources :todolists
      root 'todolists#index'
    end
  end

  get "/:single_page" , to: "staticpages#show", :as=> 'page'
  # 基本routes應用：https://railsbook.tw/chapters/11-routes.html
end
