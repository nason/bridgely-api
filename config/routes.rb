BridgelyApi::Application.routes.draw do

  namespace :v1 do
    # Sessions
    post "/auth/login"     => "sessions#create"
    delete "/auth/logout"  => "sessions#destroy"

    # Twilio
    post "/twilio/inbound" => "twilio#create"
    post "/twilio/status"  => "twilio#update"

    resources :questions, except: [:new, :edit]
    resources :messages, except: [:new, :edit]
    resources :employees, except: [:new, :edit]

    # Get a company's employee directory
    get "/companies/:company_id/employees" => "employees#company_index"

    # Get a company's message records
    get "/companies/:company_id/messages" => "messages#company_index"

    # Get a company's user list
    get "/companies/:company_id/users" => 'users#company_index'

    # Get an employee's messages
    get "/employees/:employee_id/messages" => 'messages#employee_index'

    #Get a question's employees
    get "/questions/:question_id/employees" => 'questions#employee_index'

    namespace :admin do
      devise_for :users, :class_name => "V1::Admin::User", :skip => :all
      resources :users, except: [:new, :edit]
      resources :companies, except: [:new, :edit]
    end
  end

  # CORS Headers
  match '*all' => 'application#cors', via: [:options], format: false

end
