Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  # 慣例：名字後須 +s
  scope module: 'admin' do
    resources :lab_forum do
      resources :comments
      get 'status', on: :member
    end
    root 'lab_forum#index'
  end

  scope module: 'assignment' do
    resources :todolists do
      get 'status', on: :member
    end
    root 'todolists#index'
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
  get 'bmi', to: "bmi#index"
  post 'bmi', to: "bmi#result"

  # get, post自己寫
  get 'name', to: "name#index"
  post 'name', to: "name#post_result"
  get 'username', to: "name#get_result"

  # 寫在最後一行
  # 基本routes應用：https://railsbook.tw/chapters/11-routes.html
  get "/:single_page" , to: "staticpages#show", as: 'page'
end
