class Organization < ActiveRecord::Base
	has_many :departments
	has_many :organization_members
	belongs_to :organization_type
end
