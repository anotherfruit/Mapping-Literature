# This is an auto-generated file: don't edit!
# You can add your own routes in the config/routes.rb file
# which will override the routes in this file.

MappingLiterature::Application.routes.draw do


  # Index action routes for controller "gpscoordsets"
  get 'gpscoordsets/timemap(.:format)', :as => 'timemap_gpscoordsets'

  # Resource routes for controller "gpscoordsets"
  get 'gpscoordsets/new(.:format)' => 'gpscoordsets#new', :as => 'new_gpscoordset'
  get 'gpscoordsets/:id/edit(.:format)' => 'gpscoordsets#edit', :as => 'edit_gpscoordset'
  get 'gpscoordsets/:id(.:format)' => 'gpscoordsets#show', :as => 'gpscoordset', :constraints => { :id => %r([^/.?]+) }
  post 'gpscoordsets(.:format)' => 'gpscoordsets#create', :as => 'create_gpscoordset'
  put 'gpscoordsets/:id(.:format)' => 'gpscoordsets#update', :as => 'update_gpscoordset', :constraints => { :id => %r([^/.?]+) }
  delete 'gpscoordsets/:id(.:format)' => 'gpscoordsets#destroy', :as => 'destroy_gpscoordset', :constraints => { :id => %r([^/.?]+) }

  # Owner routes for controller "gpscoordsets"
  get 'fragments/:fragment_id/gpscoordsets/new(.:format)' => 'gpscoordsets#new_for_fragment', :as => 'new_gpscoordset_for_fragment'
  post 'fragments/:fragment_id/gpscoordsets(.:format)' => 'gpscoordsets#create_for_fragment', :as => 'create_gpscoordset_for_fragment'


  # Resource routes for controller "genres"
  get 'genres(.:format)' => 'genres#index', :as => 'genres'
  get 'genres/new(.:format)' => 'genres#new', :as => 'new_genre'
  get 'genres/:id/edit(.:format)' => 'genres#edit', :as => 'edit_genre'
  get 'genres/:id(.:format)' => 'genres#show', :as => 'genre', :constraints => { :id => %r([^/.?]+) }
  post 'genres(.:format)' => 'genres#create', :as => 'create_genre'
  put 'genres/:id(.:format)' => 'genres#update', :as => 'update_genre', :constraints => { :id => %r([^/.?]+) }
  delete 'genres/:id(.:format)' => 'genres#destroy', :as => 'destroy_genre', :constraints => { :id => %r([^/.?]+) }


  # Resource routes for controller "authors"
  get 'authors(.:format)' => 'authors#index', :as => 'authors'
  get 'authors/new(.:format)' => 'authors#new', :as => 'new_author'
  get 'authors/:id/edit(.:format)' => 'authors#edit', :as => 'edit_author'
  get 'authors/:id(.:format)' => 'authors#show', :as => 'author', :constraints => { :id => %r([^/.?]+) }
  post 'authors(.:format)' => 'authors#create', :as => 'create_author'
  put 'authors/:id(.:format)' => 'authors#update', :as => 'update_author', :constraints => { :id => %r([^/.?]+) }
  delete 'authors/:id(.:format)' => 'authors#destroy', :as => 'destroy_author', :constraints => { :id => %r([^/.?]+) }


  # Index action routes for controller "creations"
  get 'creations/complete_title(.:format)', :as => 'complete_title_creations'

  # Resource routes for controller "creations"
  get 'creations(.:format)' => 'creations#index', :as => 'creations'
  get 'creations/new(.:format)' => 'creations#new', :as => 'new_creation'
  get 'creations/:id/edit(.:format)' => 'creations#edit', :as => 'edit_creation'
  get 'creations/:id(.:format)' => 'creations#show', :as => 'creation', :constraints => { :id => %r([^/.?]+) }
  post 'creations(.:format)' => 'creations#create', :as => 'create_creation'
  put 'creations/:id(.:format)' => 'creations#update', :as => 'update_creation', :constraints => { :id => %r([^/.?]+) }
  delete 'creations/:id(.:format)' => 'creations#destroy', :as => 'destroy_creation', :constraints => { :id => %r([^/.?]+) }


  # Index action routes for controller "fragments"
  get 'fragments/rss(.:format)', :as => 'rss_fragments'

  # Resource routes for controller "fragments"
  get 'fragments(.:format)' => 'fragments#index', :as => 'fragments'
  get 'fragments/new(.:format)' => 'fragments#new', :as => 'new_fragment'
  get 'fragments/:id/edit(.:format)' => 'fragments#edit', :as => 'edit_fragment'
  get 'fragments/:id(.:format)' => 'fragments#show', :as => 'fragment', :constraints => { :id => %r([^/.?]+) }
  post 'fragments(.:format)' => 'fragments#create', :as => 'create_fragment'
  put 'fragments/:id(.:format)' => 'fragments#update', :as => 'update_fragment', :constraints => { :id => %r([^/.?]+) }
  delete 'fragments/:id(.:format)' => 'fragments#destroy', :as => 'destroy_fragment', :constraints => { :id => %r([^/.?]+) }

  # Owner routes for controller "fragments"
  get 'creations/:creation_id/fragments(.:format)' => 'fragments#index_for_creation', :as => 'fragments_for_creation'
  get 'creations/:creation_id/fragments/new(.:format)' => 'fragments#new_for_creation', :as => 'new_fragment_for_creation'
  post 'creations/:creation_id/fragments(.:format)' => 'fragments#create_for_creation', :as => 'create_fragment_for_creation'


  # Lifecycle routes for controller "users"
  put 'users/:id/accept_invitation(.:format)' => 'users#do_accept_invitation', :as => 'do_user_accept_invitation'
  get 'users/:id/accept_invitation(.:format)' => 'users#accept_invitation', :as => 'user_accept_invitation'
  put 'users/:id/reset_password(.:format)' => 'users#do_reset_password', :as => 'do_user_reset_password'
  get 'users/:id/reset_password(.:format)' => 'users#reset_password', :as => 'user_reset_password'

  # Resource routes for controller "users"
  get 'users/:id/edit(.:format)' => 'users#edit', :as => 'edit_user'
  get 'users/:id(.:format)' => 'users#show', :as => 'user', :constraints => { :id => %r([^/.?]+) }
  post 'users(.:format)' => 'users#create', :as => 'create_user'
  put 'users/:id(.:format)' => 'users#update', :as => 'update_user', :constraints => { :id => %r([^/.?]+) }
  delete 'users/:id(.:format)' => 'users#destroy', :as => 'destroy_user', :constraints => { :id => %r([^/.?]+) }

  # Show action routes for controller "users"
  get 'users/:id/account(.:format)' => 'users#account', :as => 'user_account'

  # User routes for controller "users"
  match 'login(.:format)' => 'users#login', :as => 'user_login'
  get 'logout(.:format)' => 'users#logout', :as => 'user_logout'
  match 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password'

  namespace :admin do


    # Lifecycle routes for controller "admin/users"
    post 'users/invite(.:format)' => 'users#do_invite', :as => 'do_user_invite'
    get 'users/invite(.:format)' => 'users#invite', :as => 'user_invite'

    # Resource routes for controller "admin/users"
    get 'users(.:format)' => 'users#index', :as => 'users'
    get 'users/new(.:format)' => 'users#new', :as => 'new_user'
    get 'users/:id/edit(.:format)' => 'users#edit', :as => 'edit_user'
    get 'users/:id(.:format)' => 'users#show', :as => 'user', :constraints => { :id => %r([^/.?]+) }
    post 'users(.:format)' => 'users#create', :as => 'create_user'
    put 'users/:id(.:format)' => 'users#update', :as => 'update_user', :constraints => { :id => %r([^/.?]+) }
    delete 'users/:id(.:format)' => 'users#destroy', :as => 'destroy_user', :constraints => { :id => %r([^/.?]+) }

  end

end
