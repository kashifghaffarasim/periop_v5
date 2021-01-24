Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  scope '/api' do
    defaults :format => 'json' do
      resource :ping, only: :show
      resources :questions, only: :index
      resources :assessments, only: [:index, :show, :create, :update]
    end
  end

  get '/hq' => 'home#hq'
  get '/*path' => 'home#index', constraints: {format: 'html', path: /(?!assets|fonts|favicon\.ico).+/}

  resources :welcome
  root 'welcome#index'

end
