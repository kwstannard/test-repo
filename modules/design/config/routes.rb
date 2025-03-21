Design::Engine.routes.draw do
  root to: redirect("/design/animal_feedings")
  resources(:animal_feedings)
end

Rails.application.routes.draw do
  mount Design::Engine, at: '/design'
end
