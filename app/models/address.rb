class Address < ActiveRecord::Base
    belongs_to :shelters
    belongs_to :people
    belongs_to :families
end
