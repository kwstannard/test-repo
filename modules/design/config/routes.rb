Design::Engine.routes.draw do
  root to: "application#introduction"
  resources(:animal_feedings)
end

Rails.application.routes.draw do
  mount Design::Engine, at: '/design'
end
