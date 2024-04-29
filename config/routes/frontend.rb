# frozen_string_literal: true

devise_for :annotators, only: %i[passwords invitations],
  controllers: { invitations: "annotators/invitations", passwords: "annotators/passwords" }

devise_scope :annotator do
  get "annotators/login", to: "annotators/sessions#new", as: :new_annotator_session
  post "annotators/login", to: "annotators/sessions#create", as: :annotator_session
  delete "annotators/logout", to: "annotators/sessions#destroy", as: :destroy_annotator_session
end

namespace "annotators" do
  authenticated :annotator do
    get "assigned", to: "tasks#assigned", as: :assigned
    get "completed", to: "tasks#completed", as: :completed
  end

  resources :tasks, only: [:assigned] do
    member do
      patch :complete
    end
    resources :text_lines, only: [:index, :show]
  end
end
