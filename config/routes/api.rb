# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :tasks, only: [] do
      resources :text_lines, only: [] do
        resources :annotations, only: [:create, :index] do
          delete :destroy, on: :collection
          put :update, on: :collection
        end
      end
      resources :taxonomies, only: [:index]
      resources :text_lines, only: [:show]
    end
  end
end
