require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it {should have_many :actor_movies}
    it {should have_many(:movies).through(:actor_movies)}
  end

  it 'Sorts by age, youngest first' do 
    actor_1 = Actor.create!(name: 'Tom Cruise', age: 60)
    actor_2 = Actor.create!(name: 'Jackie Chan', age: 70)
    actor_3 = Actor.create!(name: 'Miley Cyrus', age: 30)
    actor_4 = Actor.create!(name: 'Anthony Anderson', age: 50)

    expect(Actor.sort_by_age).to eq([actor_3, actor_4, actor_1, actor_2])
  end

  it 'Calculates average age, rounded to tenth' do 
    actor_1 = Actor.create!(name: 'Tom Cruise', age: 66)
    actor_2 = Actor.create!(name: 'Jackie Chan', age: 77)
    actor_3 = Actor.create!(name: 'Miley Cyrus', age: 32)
    actor_4 = Actor.create!(name: 'Anthony Anderson', age: 55)

    expect(Actor.average_age).to eq(57.5)
  end
end