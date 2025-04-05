Database::Engine.routes.draw do
  resources(:providers) do
    resources :clients, controller: 'providers_clients', param: :client_id
  end
  resources(:clients) do
    resources :providers, controller: 'clients_providers', param: :provider_id
    resources :journals
  end
  resources :journals, only: [] do
    resources :notes
  end
  root to: 'application#introduction'
end

Rails.application.routes.draw do
  mount Database::Engine => "/database"
end
