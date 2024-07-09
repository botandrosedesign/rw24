# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

[
  {
    id: 1,
    name: "A Team",
    min: 2,
    max: 6,
    initial: "A",
  },
  {
    id: 2,
    name: "B Team",
    min: 2,
    max: 6,
    initial: "B",
  },
  {
    id: 3,
    name: "Elder Team",
    min: 2,
    max: 6,
    initial: "E",
  },
  {
    id: 4,
    name: "Solo (male)",
    min: 1,
    max: 1,
    initial: "S",
  },
  {
    id: 5,
    name: "Solo (female)",
    min: 1,
    max: 1,
    initial: "S",
  },
  { 
    id: 6,
    name: "Solo (elder)",
    min: 1,
    max: 1,
    initial: "S"
  },
  {
    id: 7,
    name: "Tandem",
    min: 2,
    max: 2,
    initial: "T",
  },
  {
    id: 8,
    name: "Tandem (elder)",
    min: 2,
    max: 2,
    initial: "T",
  },
  {
    id: 9,
    name: "Convoy",
    min: 2,
    max: 6,
    initial: "C",
  },
  {
    id: 10,
    name: "Perfect Strangers",
    min: 2,
    max: 6,
    initial: "P"
  },

  {
    id: 11,
    initial: "S",
    name: "Solo (open)",
    min: 1,
    max: 1,
  },
  {
    id: 12,
    initial: "M",
    name: "Solo (M/T/NB)",
    min: 1,
    max: 1,
  },
  { 
    id: 13,
    initial: "F",
    name: "Solo (F/T/NB)",
    min: 1,
    max: 1,
  },
  {
    id: 14,
    initial: "B",
    name: "Team",
    min: 2,
    max: 6,
  },
  {
    id: 15,
    initial: "E",
    name: "Elder",
    min: 1,
    max: 6,
  },
].each do |attributes|
  TeamCategory.where(id: attributes[:id]).first_or_initialize.update!(attributes)
end

