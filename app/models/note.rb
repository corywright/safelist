class Note < ActiveRecord::Base
    has_and_belongs_to_many :people
    has_and_belongs_to_many :volunteers
    has_and_belongs_to_many :organization_members
    has_and_belongs_to_many :organizations
    has_and_belongs_to_many :departments
    has_and_belongs_to_many :families
    has_and_belongs_to_many :shelters
    has_and_belongs_to_many :injury_reports
end
