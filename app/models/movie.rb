class Movie < ApplicationRecord
  belongs_to :studio
  has_many :actors, through: :actors_movies
end
