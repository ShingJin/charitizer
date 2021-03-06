Charitizer::Application.routes.draw do
  resources :rules
  resources :shops

  resources :contact_forms
  
  resources :rules do
    member do
      post :pay
    end
  end

  resources :home do 
    member do
      post :submit_plan
    end
  end
 
  get 'total_amount' => 'rules#total_amount'
  get 'help' => 'contact_forms#new'
  get 'welcome' => 'home#welcome'
  get 'design' => 'home#design'
  get 'create' => 'rules#new'
  get 'view'   => 'rules#index'
  get 'notifications' => 'rules#notifications'
  get 'payments' => 'rules#payments'
  get 'widgets' => 'home#widgets'
  get 'plan' =>  'home#plan'
  post 'submit_plan' => 'home#submit_plan'
  get 'get_widget_info' => 'shops#get_widget_info'



  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'auth/shopify/callback' => :show
    delete 'logout' => :destroy
  end

  root :to => 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed withu "root"
  #root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
ok here are the steps

1. go to shops_controller.rb 
and add this method
def uninstall
    domain = request.env["HTTP_X_SHOPIFY_SHOP_DOMAIN"]
    shop = Shop.where("domain =?", domain).first
    shop.destroy
end

2. add   
get 'uninstall' => 'shops#uninstall'
in routes.rb

3. commit and push all changes to heroku

4. go to Admin Settings > Notifications and create a webhook that redirects to your app once the user uninstall the app
http://docs.shopify.com/manual/settings/notifications/webhooks

the url should be charitizer.herokuapp.com/uninstall