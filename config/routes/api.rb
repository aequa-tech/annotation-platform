# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :annotations, only: [:create, :index] do
      delete :destroy, on: :collection
    end
  end
end
