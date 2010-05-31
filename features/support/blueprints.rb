require "machinist/active_record"
require "faker"

Sham.name { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.sentence { Faker::Lorem.sentence }
Sham.paragraph { Faker::Lorem.paragraph }
Sham.url { "http://#{Faker::Internet.domain_name}/#{Faker::Lorem.words(3).join('_').downcase}" }

Sham.address { Faker::Address.street_address }
Sham.city { Faker::Address.city }
Sham.zip { Faker::Address.zip_code }
Sham.phone { Faker::PhoneNumber.phone_number }
