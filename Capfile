# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/rbenv'
require 'capistrano3/unicorn'

# Includes default deployment tasks
require 'capistrano/deploy'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
