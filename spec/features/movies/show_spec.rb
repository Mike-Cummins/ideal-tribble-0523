require 'rails_helper'

RSpec.describe 'Movies Show' do
  describe 'As a user, when I visit a movie show page' do
    before :each do
      @studio_1 = Studio.create!(name: "Universal", location: "Hollywood")
      @studio_2 = Studio.create!(name: "Paramount", location: "Burbank")
      @movie_1 = @studio_1.movies.create!(title: "Big Lebowski", creation_year: 1999, genre: 'Comedy')
      @movie_2 = @studio_2.movies.create!(title: "South Park", creation_year: 2020, genre: 'Comedy')
      @actor_1 = @movie_1.actors.create!(name: 'Tom Cruise', age: 60)
      @actor_2 = @movie_1.actors.create!(name: 'Jackie Chan', age: 70)
      @actor_3 = @movie_1.actors.create!(name: 'Miley Cyrus', age: 30)
      @actor_4 = @movie_2.actors.create!(name: 'Anthony Anderson', age: 50)
    end

    it 'Displays the movie title, creation year, and genre' do 
      visit "/movies/#{@movie_1.id}"

      expect(page).to have_content(@movie_1.title)
      expect(page).to have_content(@movie_1.genre) 
      expect(page).to have_content(@movie_1.creation_year)
      expect(page).to_not have_content(@movie_2.title)
    end

    it 'Displays all of the actors listed from youngest to oldest' do 
      visit "/movies/#{@movie_1.id}"

      expect(@actor_3.name).to appear_before(@actor_1.name)
      expect(@actor_1.name).to appear_before(@actor_2.name)
      expect(page).to_not have_content(@actor_4.name)
    end

    it 'Displays the average age of all actors' do 
      visit "/movies/#{@movie_1.id}"

      expect(page).to have_content("Average Actor Age: 53.3")
    end
  end
end