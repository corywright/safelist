class OrganizationMember < ActiveRecord::Base
	belongs_to :organization
	belongs_to :department
end
