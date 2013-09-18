require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/twitter.rb'
include Twitter

puts Twitter

get '/' do

  @show_desc = nil
  erb :index
end

post '/twitter' do
  erb :results

end
