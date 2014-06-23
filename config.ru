require 'sinatra'
$:.unshift __dir__ + '/app'
$:.unshift __dir__ + '/lib'

require 'jubataas'
require 'jubatus_core'

run JubataaS
