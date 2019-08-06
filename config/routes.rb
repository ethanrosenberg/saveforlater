Rails.application.routes.draw do
  #get 'dropbox/fetch'
 get '/', to: 'dropbox#call'
  #scope '/api/v1' do
  #  get '/updatePhotos', to: 'search#parse'
  #  post '/phoneSearch', to: 'phone#search'
#  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
