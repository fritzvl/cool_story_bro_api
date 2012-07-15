require "bundler/setup"
Bundler.require(:default)

require 'resque/tasks'
require File.expand_path("../lib/util", __FILE__)+"/audio_processor.rb"

task "resque:setup" do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"