class Studio < ApplicationRecord
  has_many :movies
  has_many :actor_movies, through: :movies

  def working_actors_old_to_young
    movies.joins(:actors)
          .where("actors.currently_working = true")
          .distinct
          .order("age desc")
          .select(:name, :age)
  end
end
