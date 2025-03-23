Database::Engine.routes.draw do
  resources(:providers)
  resources(:clients) do
    resources :providers, controller: 'clients_providers', param: :provider_id
    resources :journals
  end
  resources :journals, only: [] do
    resources :notes
  end
  root to: redirect('/database/clients')
end

Rails.application.routes.draw do
  mount Database::Engine => "/database"
end
