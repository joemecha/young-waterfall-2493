require 'rails_helper'

RSpec.describe 'the movie show page' do
  before(:each) do
    @studio_1 = Studio.create!(name: "Studio 1", location: "Vancouver, BC")
    @movie_1 = @studio_1.movies.create!(title: "Movie 1", creation_year: "2010", genre: "drama")

    @actor_1 = Actor.create!(name: "Rod", age: "30", currently_working: true)
    @actor_2 = Actor.create!(name: "Betty", age: "25", currently_working: true)
    @actor_3 = Actor.create!(name: "Jimmy", age: "75", currently_working: false)
    @actor_4 = Actor.create!(name: "Doris", age: "35", currently_working: true)

    ActorMovie.create(actor_id: @actor_1.id, movie_id: @movie_1.id)
    ActorMovie.create(actor_id: @actor_2.id, movie_id: @movie_1.id)
    ActorMovie.create(actor_id: @actor_3.id, movie_id: @movie_1.id)

    visit  "/studios/#{@studio_1.id}/movies/#{@movie_1.id}"
  end

  it "shows the movie's title, creation year and genre" do
    expect(page).to have_content(@movie_1.title)
    expect(page).to have_content(@movie_1.creation_year)
    expect(page).to have_content(@movie_1.genre)
  end


  it "displays this movie's actors" do
    within "#actors" do
      expect(page).to have_content(@actor_1.name)
      expect(page).to have_content(@actor_2.name)
      expect(page).to have_content(@actor_3.name)
      expect(page).to_not have_content(@actor_4.name)
    end
  end

  it "has a form to add an actor" do
    expect(find('form')).to have_content('Add actor by name:')
    fill_in :actor_name, with: @actor_4.name

    click_on "Submit"

    expect(current_path).to eq("/studios/#{@studio_1.id}/movies/#{@movie_1.id}")
    expect(page).to have_content(@actor_4.name)
  end
end
