require 'rails_helper'

RSpec.describe 'the studio show page' do
  before(:each) do
    @studio_1 = Studio.create!(name: "Studio 1", location: "Vancouver, BC")
    @movie_1 = @studio_1.movies.create!(title: "Movie 1", creation_year: "2010", genre: "drama")
    @movie_2 = @studio_1.movies.create!(title: "Movie 2", creation_year: "2011", genre: "fantasy")
    @movie_3 = @studio_1.movies.create!(title: "Movie 3", creation_year: "2013", genre: "horror")

    @actor_1 = Actor.create!(name: "Rod", age: "30", currently_working: true)
    @actor_2 = Actor.create!(name: "Betty", age: "25", currently_working: true)
    @actor_3 = Actor.create!(name: "Jimmy", age: "75", currently_working: false)
    @actor_4 = Actor.create!(name: "Doris", age: "35", currently_working: true)

    ActorMovie.create(actor_id: 1, movie_id: 1)
    ActorMovie.create(actor_id: 1, movie_id: 2)

    ActorMovie.create(actor_id: 2, movie_id: 2)
    ActorMovie.create(actor_id: 2, movie_id: 3)

    ActorMovie.create(actor_id: 3, movie_id: 1)

    ActorMovie.create(actor_id: 4, movie_id: 3)

    visit studio_path(@studio_1)
  end

  it "shows the studio's name and location" do
    expect(page).to have_content(@studio_1.name)
    expect(page).to have_content(@studio_1.location)
  end


  it "displays studio's movies' titles" do
    within "#movie-titles" do
      expect(page).to have_content(@movie_1.title)
      expect(page).to have_content(@movie_2.title)
    end
  end

  it "lists actors that have acted in any of the studio's movies" do
    within "#actors" do
      expect(page).to have_content(@actor_1.name)
      expect(page).to have_content(@actor_2.name)
      expect(@actor_2.name).to appear_before(@actor_1.name)
    end
  end
end
