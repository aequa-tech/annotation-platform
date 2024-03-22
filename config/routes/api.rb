# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :annotations, only: [:create, :index] do
      delete :destroy, on: :collection
      put :update, on: :collection
    end
    resources :taxonomies, only: [:index]
  end
end
