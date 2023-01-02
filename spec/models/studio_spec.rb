require 'rails_helper'

RSpec.describe Studio do
  describe 'relationships' do
    it {should have_many :movies}
  end

  it 'Can make a unique list of all the actors for all movies from the studio' do
    @studio_1 = Studio.create!(name: "Universal", location: "Hollywood")
    @studio_2 = Studio.create!(name: "Paramount", location: "Hollywood")
    @movie_1 = @studio_1.movies.create!(title: "Big Lebowski", creation_year: 1999, genre: 'Comedy')
    @movie_2 = @studio_1.movies.create!(title: "South Park", creation_year: 2020, genre: 'Comedy')
    @actor_1 = Actor.create!(name: 'Tom Cruise', age: 60)
    @actor_2 = Actor.create!(name: 'Jackie Chan', age: 70)
    @actor_3 = Actor.create!(name: 'Miley Cyrus', age: 30)
    @actor_4 = Actor.create!(name: 'Anthony Anderson', age: 50)
    ActorMovie.create!(actor: @actor_1, movie: @movie_1)
    ActorMovie.create!(actor: @actor_1, movie: @movie_2)
    ActorMovie.create!(actor: @actor_2, movie: @movie_1)
    ActorMovie.create!(actor: @actor_2, movie: @movie_2)
    ActorMovie.create!(actor: @actor_3, movie: @movie_1)
    ActorMovie.create!(actor: @actor_4, movie: @movie_1)

    expect(@studio_1.all_actors).to eq([@actor_1, @actor_2, @actor_3, @actor_4])
  end
end
