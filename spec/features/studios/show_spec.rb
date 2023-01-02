require 'rails_helper'

RSpec.describe 'Studio Show' do
  describe 'As a user, when I visit a studio show page' do
    before :each do
      @studio_1 = Studio.create!(name: "Universal", location: "Hollywood")
      @studio_2 = Studio.create!(name: "Paramount", location: "Hollywood")
      @movie_1 = @studio_1.movies.create!(title: "Big Lebowski", creation_year: 1999, genre: 'Comedy')
      @movie_2 = @studio_1.movies.create!(title: "South Park", creation_year: 2020, genre: 'Comedy')
      @movie_3 = @studio_2.movies.create!(title: "Fight Club", creation_year: 2020, genre: 'Drama')
      @actor_1 = Actor.create!(name: 'Tom Cruise', age: 60)
      @actor_2 = Actor.create!(name: 'Jackie Chan', age: 70)
      @actor_3 = Actor.create!(name: 'Miley Cyrus', age: 30)
      @actor_4 = Actor.create!(name: 'Anthony Anderson', age: 50)
      @actor_5 = Actor.create!(name: "Edward Norton", age: 55)
      ActorMovie.create!(actor: @actor_1, movie: @movie_1)
      ActorMovie.create!(actor: @actor_1, movie: @movie_2)
      ActorMovie.create!(actor: @actor_2, movie: @movie_1)
      ActorMovie.create!(actor: @actor_2, movie: @movie_2)
      ActorMovie.create!(actor: @actor_3, movie: @movie_1)
      ActorMovie.create!(actor: @actor_4, movie: @movie_1)
      ActorMovie.create!(actor: @actor_5, movie: @movie_3)
    end

    it 'Displays the studio name and location' do
      visit "/studios/#{@studio_1.id}"

      expect(page).to have_content(@studio_1.name)
      expect(page).to have_content(@studio_1.location)
      expect(page).to_not have_content(@studio_2.name)
    end

    it 'Displays a unique list of all actors that have worked on their films' do
      visit "/studios/#{@studio_1.id}"

      within "#all_actors" do
        expect(page).to have_content(@actor_1.name).once
        expect(page).to have_content(@actor_2.name).once
        expect(page).to have_content(@actor_3.name).once
        expect(page).to have_content(@actor_4.name).once
        expect(page).to_not have_content(@actor_5.name)
      end
    end
  end
end
