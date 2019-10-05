Rails.application.routes.draw do
  devise_for :users

  namespace :forum do
    resources :lab911
    root "lab911#index"
  end

  get '/home', to: 'staticpages#home'
  get '/help', to: 'staticpages#help'
  get '/todo', to: 'staticpages#todo'
  # 基本routes應用：https://railsbook.tw/chapters/11-routes.html
end
