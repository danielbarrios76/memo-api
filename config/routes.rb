require 'api_constraints.rb'

Rails.application.routes.draw do
  scope module: :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1,
                                                       default: true) do

      # Version
      get 'version' => 'version#show'

      # Memos
      resources :memos
    end
  end
end
