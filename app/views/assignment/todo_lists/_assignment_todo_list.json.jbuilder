json.extract! todo_list, :id, :name, :created_at, :updated_at
json.url assignment_todo_list_url(todo_list, format: :json)
