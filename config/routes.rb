Rails.application.routes.draw do
  devise_for :customers,
    controllers:{omniauth_callbacks: "customers/omniauth_callbacks"}
  root to: "pages#show"
end
