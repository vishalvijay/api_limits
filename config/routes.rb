Rails.application.routes.draw do
  	devise_for :users, path: "api/v1/users"
	namespace :api do
	    namespace :v1 do
	    	resources :users, :only =>[:index] do
	    		collection do
	    			get :profile
	    		end
	      	end
	    end
	end
	devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)
	root to: "admin/users#index"
end
