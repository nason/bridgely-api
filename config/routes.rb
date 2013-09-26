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

    get "/employees/company/:company_id" => "employees#company_index"

    namespace :admin do
      devise_for :users, :class_name => "V1::Admin::User", :skip => :all
      resources :users, except: [:new, :edit]
      resources :companies, except: [:new, :edit]
    end
  end

  # CORS Headers
  match '*all' => 'application#cors', via: [:options], format: false

end
