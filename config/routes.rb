Rails.application.routes.draw do
  get '/home', to: 'staticpages#home'
  get '/help', to: 'staticpages#help'
  get '/todo', to: 'staticpages#todo'
  # 基本routes應用：https://railsbook.tw/chapters/11-routes.html
end
