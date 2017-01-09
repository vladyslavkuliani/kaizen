Rails.application.routes.draw do

  root 'sessions#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'managers#new'
  post '/managers' => 'managers#create'
  get '/managers/:name' => 'managers#show', as: 'manager'
  get '/profile' => 'managers#profile'
  get '/edit' => 'managers#edit'
  put '/profile' => 'managers#update'
  patch '/profile' => 'managers#update'
  delete '/profile' => 'managers#delete'

  get '/projects' => 'projects#index'
  get '/projects/new' => 'projects#new', as: 'new_project'
  post '/projects' => 'projects#create'
  get '/projects/:title' => 'projects#show', as: 'project'
  get '/projects/:title' => 'projects#edit', as: 'edit_project'
  put '/projects/:title' => 'projects#update'
  patch '/projects/:title' => 'projects#update'
  delete '/projects/:title' => 'projects#delete'

  get '/staff' => 'developers#index'
  get '/staff/new' => 'developers#new', as: 'new_dev'
  post '/staff' => 'developers#create'
  get '/staff/:name' => 'developers#show', as: 'dev'
  get '/staff/:name' => 'developers#edit', as: 'edit_dev'
  put '/staff/:name' => 'developers#update'
  patch '/staff/:name' => 'developers#update'
  delete '/staff/:name' => 'developers#delete'

  get '/skills' => 'skills#index'
  get '/skills/new' => 'skills#new', as: 'new_skill'
  post '/skills' => 'skills#create'
  get '/skills/:skill' => 'skills#show', as: 'skill'
  get '/skills/:skill' => 'skills#edit', as: 'edit_skill'
  put '/skills/:skill' => 'skills#update'
  patch '/skills/:skill' => 'skills#update'
  delete '/skills/:skill' => 'skills#delete'

end
