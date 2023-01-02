class Studio < ApplicationRecord
  has_many :movies
  has_many :actors, through: :movies

  def all_actors
    actors.distinct
  end
end
