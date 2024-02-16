# frozen_string_literal: true

devise_for :editors, skip: :all
devise_scope :editor do
  get "management/login" => "management/editors/sessions#new", :as => :new_editor_session
  post "management/login" => "management/editors/sessions#create", :as => :editor_session
  delete "management/logout" => "management/editors/sessions#destroy", :as => :destroy_editor_session
  get "editors/edit" => "management/editors/registrations#edit", :as => :edit_editor_registration
  put "editors" => "management/editors/registrations#update", :as => :editor_registration
end

namespace "management" do
  authenticated :editor do
    root to: "annotators#index", as: :root
  end
  devise_scope :editor do
    root to: "editors/sessions#new", as: :unauthenticated_root
  end
  resources :annotators
  resources :taxonomies
end
