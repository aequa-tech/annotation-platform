# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :annotations, only: [:create, :index]
  end
end
