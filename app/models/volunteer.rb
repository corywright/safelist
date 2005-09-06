class Volunteer < ActiveRecord::Base
  protected
    def validate
      errors.add_on_empty %w( first_name last_name )
      errors.add("home_phone", "has invalid format") unless home_phone =~ /[0-9]*/
    end

    def validate_on_update
      errors.add_to_base("No changes have occurred") if unchanged_attributes?
    end
end
