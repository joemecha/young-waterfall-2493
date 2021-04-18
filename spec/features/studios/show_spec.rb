require 'rails_helper'

RSpec.describe 'the studio show page' do
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

    @actor_5 = Actor.create!(name: "Ralph", age: "30", currently_working: true)
    @actor_6 = Actor.create!(name: "Forsynthia", age: "27", currently_working: true)

    ActorMovie.create(actor_id: @actor_1.id, movie_id: @movie_1.id)
    ActorMovie.create(actor_id: @actor_1.id, movie_id: @movie_1.id)

    ActorMovie.create(actor_id: @actor_2.id, movie_id: @movie_2.id)
    ActorMovie.create(actor_id: @actor_2.id, movie_id: @movie_3.id)

    ActorMovie.create(actor_id: @actor_3.id, movie_id: @movie_1.id)

    ActorMovie.create(actor_id: @actor_4.id, movie_id: @movie_3.id)

    ActorMovie.create(actor_id: @actor_5.id, movie_id: @movie_4.id)
    ActorMovie.create(actor_id: @actor_6.id, movie_id: @movie_5.id)

    visit studio_path(@studio_1)
  end

  it "shows the studio's name and location" do
    expect(page).to have_content(@studio_1.name)
    expect(page).to have_content(@studio_1.location)

    expect(page).to_not have_content(@studio_2.name)
    expect(page).to_not have_content(@studio_2.location)
  end


  it "displays studio's movies' titles" do
    within "#movie-titles" do
      expect(page).to have_content(@movie_1.title)
      expect(page).to have_content(@movie_2.title)
      expect(page).to_not have_content(@movie_5.title)
    end
  end

  it "lists actors that have acted in any of the studio's movies" do
    within "#working-actors" do
      expect(page).to have_content(@actor_1.name)
      expect(page).to have_content(@actor_2.name)
      expect(page).to have_content(@actor_4.name)

      expect(page).to_not have_content(@actor_3.name)
      expect(page).to_not have_content(@actor_5.name)
      expect(page).to_not have_content(@actor_6.name)

      expect(@actor_4.name).to appear_before(@actor_1.name)
      expect(@actor_1.name).to appear_before(@actor_2.name)
    end
  end
end
