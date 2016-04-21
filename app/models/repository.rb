class Repository < ActiveRecord::Base
    validates_uniqueness_of :name
	validates_presence_of :name, :url

    def self.search(search)
        where("name LIKE ?", "%#{search}%")
        where("description LIKE ?", "%#{search}%")
    end
end
