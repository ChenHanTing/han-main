Rails.application.routes.draw do
  # namespace :forum do
  #   get 'lab911/index'
  #   get 'lab911/show'
  #   get 'lab911/edit'
  # end

  namespace :forum do
    resources :lab911
  end

  get '/home', to: 'staticpages#home'
  get '/help', to: 'staticpages#help'
  get '/todo', to: 'staticpages#todo'
  # 基本routes應用：https://railsbook.tw/chapters/11-routes.html
end
