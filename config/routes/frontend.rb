# frozen_string_literal: true

devise_for :annotators, skip: :all

devise_scope :annotator do
  get :login, to: "annotators/sessions#new", as: :new_annotator_session
  post :login, to: "annotators/sessions#create", as: :annotator_session
  delete :logout, to: "annotators/sessions#destroy", as: :destroy_annotator_session
end

authenticated :annotator do
  root to: "tasks#assigned", as: :root
end

devise_scope :annotator do
  root to: "annotators/sessions#new", as: :unauthenticated_root
end
