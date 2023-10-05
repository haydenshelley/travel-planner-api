class Trip < ApplicationRecord
  has_many :places
  has_many :travelers
  belongs_to :user
end
