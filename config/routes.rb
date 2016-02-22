Rails.application.routes.draw do

  root 'pages#index'

  controller :pages do
    get '/'         => :index,  as: 'pages'
    post '/'        => :create
    get '/add'      => :new,    as: 'new_page'
    get '/*id/edit' => :edit,   as: 'edit_page'
    get '/*id/add'  => :new,    as: 'new_sub_page'
    get '/*id'      => :show,   as: 'page'
    match '/*id'    => :update, via: [:put, :patch]
    delete '/*id'   => :destroy
  end

end
