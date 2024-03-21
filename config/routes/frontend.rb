# frozen_string_literal: true

devise_for :annotators, only: :passwords

devise_scope :annotator do
  get :login, to: "annotators/sessions#new", as: :new_annotator_session
  post :login, to: "annotators/sessions#create", as: :annotator_session
  delete :logout, to: "annotators/sessions#destroy", as: :destroy_annotator_session
end

authenticated :annotator do
  root to: "tasks#assigned", as: :root
  resources :tasks, only: [:assigned] do
    resources :text_lines, only: [:index, :show]
  end
end

devise_scope :annotator do
  root to: "annotators/sessions#new", as: :unauthenticated_root
end
