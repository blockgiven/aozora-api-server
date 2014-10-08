Rails.application.routes.draw do
  resources :books, only: :show, id: /random/ do
    resources 'sentences', only: :show, id: /1/
  end
end
