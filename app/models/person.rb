class Person < ActiveRecord::Base
    belongs_to :family
    belongs_to :person_type
    belongs_to :shelter

    def name
      first_name + " " + last_name
    end

end
