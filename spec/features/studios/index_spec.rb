require 'rails_helper'

RSpec.describe 'Studio Index' do
  describe 'As a user, when I visit the Studio Index page' do
    before :each do
      @studio_1 = Studio.create!(name: "Universal", location: "Hollywood")
      @studio_2 = Studio.create!(name: "Paramount", location: "Burbank")
      @studio_3 = Studio.create!(name: "Dimension", location: "Hollywood")
      @movie_1 = @studio_1.movies.create!(title: "Big Lebowski", creation_year: 1999, genre: 'Comedy')
      @movie_2 = @studio_2.movies.create!(title: "South Park", creation_year: 2020, genre: 'Comedy')
      @movie_3 = @studio_3.movies.create!(title: "Scream", creation_year: 2021, genre: 'Horror')
    end
    it 'Displays all studios with their name and location' do 
      visit '/studios'

      expect(page).to have_content(@studio_1.name)
      expect(page).to have_content(@studio_2.name)
      expect(page).to have_content(@studio_3.name)
      expect(page).to have_content(@studio_1.location)
      expect(page).to have_content(@studio_2.location)
      expect(page).to have_content(@studio_3.location)
    end

    it 'Displays all of the movies for each studio and their information' do
      visit '/studios'
      
      within "#studio_#{@studio_1.id}" do
        expect(page).to have_content(@movie_1.title)
        expect(page).to have_content(@movie_1.genre)
        expect(page).to have_content(@movie_1.creation_year)
        expect(page).to_not have_content(@movie_2.title)
        expect(page).to_not have_content(@movie_3.title)
      end

      within "#studio_#{@studio_2.id}" do
        expect(page).to have_content(@movie_2.title)
        expect(page).to have_content(@movie_2.genre)
        expect(page).to have_content(@movie_2.creation_year)
        expect(page).to_not have_content(@movie_1.title)
        expect(page).to_not have_content(@movie_3.title)
      end
    end
  end
end