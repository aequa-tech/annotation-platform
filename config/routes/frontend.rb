# frozen_string_literal: true

devise_for :annotators, only: :passwords

devise_scope :annotator do
  get "annotators/login", to: "annotators/sessions#new", as: :new_annotator_session
  post "annotators/login", to: "annotators/sessions#create", as: :annotator_session
  delete "annotators/logout", to: "annotators/sessions#destroy", as: :destroy_annotator_session
end

namespace "annotators" do
  authenticated :annotator do
    root to: "tasks#assigned", as: :root
  end

  # devise_scope :annotator do
  #   root to: "sessions#new", as: :unauthenticated_root
  # end

  resources :tasks, only: [:assigned] do
    resources :text_lines, only: [:index, :show]
  end
end
