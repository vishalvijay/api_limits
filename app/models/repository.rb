class Repository < ActiveRecord::Base
	validates_presence_of :name, :url
end
