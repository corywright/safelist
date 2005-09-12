class Department < ActiveRecord::Base
	has_many :organization_members
	belongs_to :organization
end
