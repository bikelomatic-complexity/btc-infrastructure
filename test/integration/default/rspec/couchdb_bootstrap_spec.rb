=begin
btc_infrastructure -- Cookbook for the Bicycle Touring Companion infrastructure
Copyright © 2016 Adventure Cycling Association

This file is part of btc_infrastructure.

btc_infrastructure is free software: you can redistribute it and/or modify
it under the terms of the Affero GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

btc_infrastructure is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
Affero GNU General Public License for more details.

You should have received a copy of the Affero GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
=end

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
