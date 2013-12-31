# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Footprints::Application.initialize!

require File.expand_path('../../lib/patches/abstract_mysql_adapter', __FILE__)
