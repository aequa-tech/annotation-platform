# frozen_string_literal: true

devise_for :editors, only: %i[passwords invitations],
  controllers: { passwords: "management/editors/passwords", invitations: "management/editors/invitations" },
  path: "management/editors",
  class_name: "Editor"

devise_scope :editor do
  get "management/login" => "management/editors/sessions#new", :as => :new_editor_session
  post "management/login" => "management/editors/sessions#create", :as => :editor_session
  delete "management/logout" => "management/editors/sessions#destroy", :as => :destroy_editor_session
  get "management/editors/edit" => "management/editors/registrations#edit", :as => :edit_editor_registration
  put "management/editors" => "management/editors/registrations#update", :as => :editor_registration
end

namespace "management" do
  authenticated :editor do
    root to: "annotators#index", as: :root
  end
  devise_scope :editor do
    root to: "editors/sessions#new", as: :unauthenticated_root
  end
  resources :annotators do
    collection do
      get :import
      post :import_csv
    end
  end
  resources :taxonomies
  resources :corpora do
    constraints(lambda { |req| req.format == :json }) do
      member do
        get :tasks_json
      end
    end
    resources :text_lines, only: [:index, :show]
    resources :lines_sets, only: [:index, :show, :edit, :update] do
      patch :undo, on: :member
      resources :text_lines, only: [:index]
      constraints(lambda { |req| req.format == :json }) do
        resources :tasks, only: [:show]
      end
    end
  end
end
