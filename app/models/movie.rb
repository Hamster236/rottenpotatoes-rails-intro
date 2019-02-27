class Movie < ActiveRecord::Base
    # To create the all_ratings, we can simply parse all the movies and store
    # them. We can also add functionality to make sure there are no doubles.
    # We create an array, parse the movies, add new ones to the array and then
    # sort them based on alphabet.
    def self.all_ratings
        the_ratings = Array.new
        self.select(:rating).uniq.each {|vals| the_ratings.push(vals.rating)}
        the_ratings.uniq.sort
    end
end
