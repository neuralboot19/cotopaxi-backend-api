class Candidate < ApplicationRecord
	has_many :users
	validates :full_name, :image, presence: true 
end
