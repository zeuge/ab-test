Rails.application.routes.draw do

  root 'pages#index'

  resources :pages, path: '/', path_names: { new: 'add' }, constraints: { id: /[\wа-яёА-ЯЁ]+/ } do
    get 'add' => :new, as: 'new_sub', on: :member
  end

end
