module Twitter
  class Tweet
    attr_accessor :hash_list, :count, :name
    
    def initialize(name)
      @name = name
      @count = 1
    end

    def add_hash
      @count += 1
    end

    def countUp
      
    end
  end
end