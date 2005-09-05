class Family < ActiveRecord::Base
    has_many :people
    belongs_to :pre_disaster_address,
               :class_name => "Address",
               :foreign_key => "pre_disaster_address_id"
    belongs_to :post_disaster_address,
               :class_name => "Address",
               :foreign_key => "post_disaster_address_id"
end
