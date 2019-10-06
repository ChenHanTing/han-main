Rails.application.routes.draw do
  devise_for :users

  namespace :forum do
    resources :lab_forum do
      resources :comments
    end
    root 'lab_forum#index'
  end

  root 'forum/lab_forum#index'
  get '/home', to: 'staticpages#home'
  get '/help', to: 'staticpages#help'
  get '/todo', to: 'staticpages#todo'
  # 基本routes應用：https://railsbook.tw/chapters/11-routes.html
end
