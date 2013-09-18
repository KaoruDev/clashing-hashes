require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'

module Twitter
  @hash_list = {
    "makersquare" => 5,
    "board" => 1
  }

  def self.compare(x, y)
    return "Sorry no such hash" if @hash_list[x] == nil && @hash_list[y] == nil
    return x if @hash_list[x] > @hash_list[y]
    return y if @hash_list[y] > @hash_list[x]
    return "Tied!" if @hash_list[x] == @hash_list[y]
  end

  def self.add_hash(name)
    if @hash_list[name] != nil
      @hash_list[name] += 1
    else
      @hash_list[name] = 1
    end
  end

  def self.hash_list
    @hash_list
  end
end


get '/' do
  @hash_list = Twitter.hash_list
  erb :index
end

post '/compare' do
  @results = Twitter.compare(params[:first_hash], params[:second_hash])
  erb :results
end

post '/tweet-add' do
  Twitter.add_hash(params[:first_hash])
  Twitter.add_hash(params[:second_hash])
  erb :add
end
