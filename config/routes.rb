Rails.application.routes.draw do
  devise_for :customers, skip: :sessions,
    controllers:{omniauth_callbacks: "customers/omniauth_callbacks"}
  devise_for :staffs, skip: [:registrations, :sessions],
    controller:{sessions: "sessions"}
    as :staff do
      get "staffs/edit" => "devise/registrations#edit",
        as: "edit_staff_registration"
      put "staffs" => "devise/registrations#update",
        as: "staff_registration"
    end

  devise_scope :staff do
    get "/login", to: "sessions#new", as: :new_customer_session
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
  root to: "pages#show"
end
