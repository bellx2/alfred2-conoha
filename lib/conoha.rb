$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'conoha/config'
require 'conoha/api'
require 'conoha/alfred'
require 'conoha/version'
