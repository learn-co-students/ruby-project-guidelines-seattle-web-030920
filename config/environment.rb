require 'bundler'
Bundler.require
require_all 'app/models'
require_all 'app/interface'


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'lib'
