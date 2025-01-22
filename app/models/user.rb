class User < ApplicationRecord
	 has_many :completes,  dependent: :destroy
	 
end
