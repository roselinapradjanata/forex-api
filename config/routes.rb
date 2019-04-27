Rails.application.routes.draw do
  scope '/api/v1' do
    resources :currency_pairs, only: [:index, :create, :destroy]
    resources :exchange_rates, only: [:create] do
      collection do
        get 'trend'
        get 'track'
      end
    end
  end
end
