#!/usr/bin/ruby

# Generate a csv list of people who have checked 
# out from a given list of shelters

require 'rubygems'
require 'active_record'
require 'csv'

if ARGV.length < 1
  puts "usage: #{$0} shelter_id [shelter_id,...]"
  exit 1
else
  arglist = ARGV.join(',')
end

# Load your yml config from rails
db_config = YAML::load(File.open("../config/database.yml"))
ActiveRecord::Base.establish_connection(db_config['development'])

require '../app/models/person'

people = Person.find_by_sql("select distinct on (family_id,last_name,p.id) " +
                            " p.first_name, p.last_name, p.family_id, p.id, p.location_description " +
                            " from events e join people p on (e.person_id = p.id) " +
                            " where e.event_type_id = '2' and p.shelter_id IN (" + arglist + ") " +
                            " order by family_id, last_name, p.id, e.event_time desc")

CSV::Writer.generate(STDOUT) do |csv|
  for person in people
    location = person.location_description.gsub(/\r?\n/m,"; ").chomp
    csv << [person.first_name, person.last_name, person.family_id, location]
  end
end
