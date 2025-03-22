Database::Engine.routes.draw do
  resources(:providers)
  resources(:clients) do
    resources :providers, controller: 'clients_providers', param: :provider_id
  end
  root to: redirect('/database/clients')
end

Rails.application.routes.draw do
  mount Database::Engine => "/database"
end
