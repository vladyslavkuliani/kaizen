Rails.application.routes.draw do

  root 'sessions#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/workflow/:title' => 'sessions#show', as: 'workflow'
  get '/about' => 'sessions#about'

  get '/signup' => 'managers#new'
  post '/managers' => 'managers#create'
  get '/managers/:name' => 'managers#show', as: 'manager'
  get '/profile' => 'managers#profile'
  get '/edit' => 'managers#edit'
  put '/profile' => 'managers#update'
  delete '/profile' => 'managers#destroy'

  get '/projects/new' => 'projects#new', as: 'new_project'
  post '/projects' => 'projects#create'
  get '/projects/:title' => 'projects#show', as: 'project'
  get '/projects/:title/edit' => 'projects#edit', as: 'edit_project'
  put '/projects/:title' => 'projects#update'
  delete '/projects/:title' => 'projects#destroy'

  # get '/tasks/new' => 'tasks#new', as: 'new_task'
  post '/tasks' => 'tasks#create'
  get '/tasks/:title' => 'tasks#show', as: 'task'
  get '/tasks/:title/edit' => 'tasks#edit', as: 'edit_task'
  put '/tasks/:title' => 'tasks#update'
  delete '/tasks/:title' => 'tasks#destroy'

  get '/team' => 'developers#index', as: 'devs'
  get '/team/new' => 'developers#new', as: 'new_dev'
  post '/team/new' => 'developers#create'
  get '/team/:name' => 'developers#show', as: 'dev'
  get '/team/:name/edit' => 'developers#edit', as: 'edit_dev'
  put '/team/:name' => 'developers#update'
  delete '/team/:name' => 'developers#destroy'

  get '/skills' => 'skills#index', as: 'skills'
  get '/skills/new' => 'skills#new', as: 'new_skill'
  post '/skills' => 'skills#create'
  get '/skills/:name' => 'skills#show', as: 'skill'
  get '/skills/:name/edit' => 'skills#edit', as: 'edit_skill'
  put '/skills/:name' => 'skills#update'
  delete '/skills/:name' => 'skills#destroy'

end
