
require 'rspec'
require 'rspec-api'

# Ensure we've created the points database
describe 'CouchDB points database' do
  resource :points do
    host 'http://localhost:5984'

    has_attribute :db_name, type: :string

    get '/points', collection: false do
      respond_with :ok
    end
  end
end

# Ensure the admin account has been setup.
# The username and password should match .kitchen.yaml
resource :config do
  describe 'Those who are authenticated' do
    host 'http://admin_username:admin_password@localhost:5984'

    get '/_config', colection: false do
      respond_with :ok
    end
  end

  describe 'Those who are not authenticated' do
    host 'http://localhost:5984'

    get '/_config', collection: false do
      respond_with :unauthorized
    end
  end
end
