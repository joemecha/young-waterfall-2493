require 'rails_helper'

RSpec.describe 'the studio show page' do
  before(:each) do
    @studio_1 = Studio.create!(name: "Studio 1", location: "Vancouver, BC")
    @movie_1 = @studio_1.movies.create!(title: "Movie 1", creation_year: "2010", genre: "drama")
    @movie_2 = @studio_1.movies.create!(title: "Movie 2", creation_year: "2011", genre: "fantasy")

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
end
