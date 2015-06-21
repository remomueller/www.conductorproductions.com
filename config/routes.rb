Rails.application.routes.draw do

  resources :projects do
    member do
      get :menu
      get :logo
    end

    resources :categories

    resources :documents do
      member do
        get :download
      end
    end
  end

  scope module: 'welcome' do
    get :dashboard
    get :index
    get :work
    get :drtv
    get :contact
    get :news
    get :about
    get :clients
    get :index_v2
    get :index_v1
  end

  scope module: 'application' do
    get :version
  end

  scope module: 'client_session' do
    get  "client/login",  action: 'new',     as: :client_login
    post "client/login",  action: 'create'
    get  "client/logout", action: 'destroy', as: :client_logout
  end

  devise_for :users, path_names: { sign_up: 'join', sign_in: 'login' }, path: ""

  scope module: 'client_project' do
    get ":id", action: 'root', as: :client_project_root
    get ":id/menu", action: 'menu', as: :client_project_menu
    get ":id/production/casting", action: 'casting', as: :client_project_casting
    get ":id/timeline", action: 'timeline', as: :client_project_timeline

    get ":id/creative/:category_id", action: 'category', as: :client_project_category
    get ":id/creative/:category_id/:document_id", action: 'document', as: :client_project_category_document
    get ":id/documents/download/:document_id", action: 'download_document', as: :client_project_download_document
    get ":id/:category_id", action: 'category'

    get ":id/casting", action: 'casting'
  end

  root 'welcome#index'

end
