Rails.application.routes.draw do

  scope "api/v1", defaults: {format: :json} do
    post 'auth/register', to: 'users#register'
    post 'auth/login', to: 'users#login'
    
    get 'time_slots/available_slots/:doctor_id', to: 'time_slots#available_slots', as: :doctor_available_slots
    get 'time_slots/doctor_slots/:doctor_id', to: 'time_slots#doctor_slots', as: :doctor_time_slots
    
    resources :appointments, only: %i(create index)
  end

end
