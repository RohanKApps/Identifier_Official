Rails.application.routes.draw do
  get '/landing' => 'application#prompt' 
  get '/zip' => 'application#login'
  get '/home' => 'application#home'
  get '/local' => 'application#local'
  get '/submit' => 'application#submit'
  get '/predict' => 'application#predict'
end
