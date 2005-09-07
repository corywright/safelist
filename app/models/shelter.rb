class Shelter < ActiveRecord::Base
    belongs_to :address, :class_name =>'Address'
end
