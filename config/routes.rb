Rails.application.routes.draw do
  scope "(:locale)", :locale => /en|es/ do
    resources :newsletters
    root :to => 'newsletters#index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
