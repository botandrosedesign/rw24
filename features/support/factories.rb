require "faker"
require "factory_bot"

FactoryBot.define do
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:name) { Faker::Name.name }
  sequence(:email) { Faker::Internet.email }
  sequence(:sentence) { Faker::Lorem.sentence }
  sequence(:paragraph) { Faker::Lorem.paragraph }
  sequence(:url) { "http://#{Faker::Internet.domain_name}/#{Faker::Lorem.words(3).join('_').downcase}" }

  sequence(:address) { Faker::Address.street_address }
  sequence(:city) { Faker::Address.city }
  sequence(:state) { Faker::Address.state }
  sequence(:zip) { Faker::Address.zip_code }
  sequence(:phone) { Faker::PhoneNumber.phone_number }

  factory :site do
    name { "Riverwest24" }
    host { "www.example.com" }
    title { "Riverwest24" }
    email { "micah@botandrose.com" }
  end

  factory :user do
    first_name
    last_name
    email
    homepage { generate(:url) }
    password { "password" }
    verified_at { Time.zone.now }
  end

  factory :page do
    path { "pages" }
    permalink { "pages" }
    title { "Pages" }
    published_at { Time.zone.parse "2008-01-01" }
    single_article_mode { false }
    comment_age { -1 }
  end

  factory :category do
    title { generate(:name) }
  end

  factory :article do
    title { generate(:sentence) }
    body { generate(:paragraph) }
    published_at { Time.zone.parse "2008-01-01" }
    association :author, factory: :user
  end

  factory :tag do
    name { generate(:word) }
  end

  factory :race do
    year { Date.today.year }
    start_time { Time.parse("#{year}-07-25 19:00:00 CDT") }
    published { true }
  end

  factory :team do
    race { Race.find_by_year Date.today.year }
    name
    address
    city
    state
    zip

    factory :team_solo do
      category { "Solo (male)" }
      before(:create) do |team|
        team.riders << FactoryBot.build(:rider)
      end
    end

    factory :team_a do
      category { "A Team" }
      before(:create) do |team|
        team.riders << FactoryBot.build(:rider)
        team.riders << FactoryBot.build(:rider)
      end
    end
  end

  factory :rider do
    name
    email
    phone
    shirt { "M" }
  end
end
