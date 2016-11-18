Rails.application.routes.draw do

  namespace :frontend do
  end
  root 'plugins/ecc/front/staticpages#index'
  get '/codes' => 'plugins/ecc/front/codes#index'
  get '/codes/:id' => 'plugins/ecc/front/codes#show'
  get '/organizations' => 'plugins/ecc/front/orgs#index'
  get '/organizations/:id' => 'plugins/ecc/front/orgs#show'
  get '/:description' => 'plugins/ecc/front/staticpages#show' 
    scope PluginRoutes.system_info["relative_url_root"] do
      scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
        # frontend
        namespace :plugins do
          namespace 'ecc' do
            get 'index' => 'front#index'
              resources :staticpages
              resources :orgs
              resources :codes
          end
        end
      end

      #Admin Panel
      scope :admin, as: 'admin', path: PluginRoutes.system_info['admin_path_name'] do
        namespace 'plugins' do
          namespace 'ecc' do
            get 'index' => 'admin#index'
            get 'settings' => 'admin/settings#index'
              resources :orgs, controller: "admin/orgs"
              resources :codes, controller: "admin/codes"
              resources :staticpages, controller: "admin/statics"
          end
        end
      end

      # main routes
      #scope 'ecc', module: 'plugins/ecc/', as: 'ecc' do
      #  Here my routes for main routes
      #end
    end
  end
