#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.
require File.expand_path("../config/boot.rb", __FILE__)

#run API::Stories
#run Padrino.application

require 'rack/raw_upload'
use Rack::RawUpload

require 'resque/server'

# Run
run Rack::URLMap.new "/" => Padrino.application, "/api" => API::Stories.new  , "/resque" => Resque::Server.new