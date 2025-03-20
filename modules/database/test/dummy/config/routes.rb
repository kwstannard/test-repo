Rails.application.routes.draw do
  mount Database::Engine => "/database"
end
