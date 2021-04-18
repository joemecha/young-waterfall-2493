require 'rails_helper'

RSpec.describe Studio do
  before(:each) do
    @studio_1 = Studio.create!(name: "Studio 1", location: "Vancouver, BC")
    @movie_1 = @studio_1.movies.create!(title: "Movie 1", creation_year: "2010", genre: "drama")
    @movie_2 = @studio_1.movies.create!(title: "Movie 2", creation_year: "2011", genre: "fantasy")
    @movie_3 = @studio_1.movies.create!(title: "Movie 3", creation_year: "2013", genre: "horror")

    @studio_2 = Studio.create!(name: "Studio 2", location: "Toronto, ON")
    @movie_4 = @studio_2.movies.create!(title: "Movie 4", creation_year: "2014", genre: "scifi")
    @movie_5 = @studio_2.movies.create!(title: "Movie 5", creation_year: "2015", genre: "thriller")

    @actor_1 = Actor.create!(name: "Rod", age: "30", currently_working: true)
    @actor_2 = Actor.create!(name: "Betty", age: "25", currently_working: true)
    @actor_3 = Actor.create!(name: "Jimmy", age: "75", currently_working: false)
    @actor_4 = Actor.create!(name: "Doris", age: "35", currently_working: true)


    ActorMovie.create(actor_id: @actor_1.id, movie_id: @movie_1.id)
    ActorMovie.create(actor_id: @actor_1.id, movie_id: @movie_1.id)

    ActorMovie.create(actor_id: @actor_2.id, movie_id: @movie_2.id)
    ActorMovie.create(actor_id: @actor_2.id, movie_id: @movie_3.id)

    ActorMovie.create(actor_id: @actor_3.id, movie_id: @movie_1.id)

    ActorMovie.create(actor_id: @actor_4.id, movie_id: @movie_3.id)
  end

  describe 'relationships' do
    it {should have_many :movies}
  end

  describe '#nstance methods' do
    it '#working_actors_old_to_young' do
      expected_first = @actor_4.name
      expected_last = @actor_2.name

      expect(@studio_1.working_actors_old_to_young.first.name).to eq(expected_first)
      expect(@studio_1.working_actors_old_to_young.last.name).to eq(expected_last)
    end
  end
end
