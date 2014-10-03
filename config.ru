require 'sinatra'
$:.unshift __dir__ + '/app'
$:.unshift __dir__ + '/lib'

require 'jubataas'
require 'jubataas_core'

run JubataaS
