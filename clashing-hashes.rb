require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'

module Twitter
  @hash_list = {
    "#makersquare" => 5,
    "#board" => 1
  }

  @tweet_list = [];

  def self.compare(x, y)
    return "Sorry no such hash" if @hash_list[x] == nil || @hash_list[y] == nil
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

  def self.tweet_list
    @tweet_list
  end

  def self.add_tweet(name, msg)
    obj = Tweet.new(name, msg)
    @tweet_list.push(obj)
  end

  def self.search_hash(msg)
    words = msg.split(" ")
    hash = []
    words.each {|word|
      hash.push(word) if word.include?("#")
    }
    if hash != []
      hash.each {|hash|
        add_hash(hash)
      }
    end
  end

  class Tweet
    attr_accessor :name, :msg

    def initialize(name, msg)
      @name = name
      @msg = msg
    end
  end
end

Twitter.add_tweet("Bob", "yay baby");
Twitter.add_tweet("smith", "yay baby");

trail = 1 # unaccessable from within other methods.
trail = some_method(trail) # Must past value through argument.
# Can reassign variable by calling a method and having the method return 
# a value. I.e. Now this will equal to 2

def some_method(number)
  number += 1
end


get '/' do
  @hash_list = Twitter.hash_list
  @tweet_list = Twitter.tweet_list
  erb :index
end

post '/' do
  Twitter.search_hash(params[:msg])
  Twitter.add_tweet(params[:name], params[:msg])
  @hash_list = Twitter.hash_list
  @tweet_list = Twitter.tweet_list
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
