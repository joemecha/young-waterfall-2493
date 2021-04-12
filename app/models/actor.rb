class Actor < ApplicationRecord
  has_many :movies, through: :actors_movies
end
