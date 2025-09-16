require "faker"
require "factory_bot"

FactoryBot.define do
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:name) { Faker::Name.name }
  sequence(:email) { Faker::Internet.email }
  sequence(:sentence) { Faker::Lorem.sentence }
  sequence(:paragraph) { Faker::Lorem.paragraph }
  sequence(:url) { "http://#{Faker::Internet.domain_name}/#{Faker::Lorem.words(number: 3).join('_').downcase}" }

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
    password { SecureRandom.hex(12) + "!" }
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
    categories { TeamCategory.all }
  end

  factory :team do
    race { Race.where(year: Date.today.year).first_or_create! }
    name
    address
    city
    state
    zip

    factory :team_solo do
      category { TeamCategory.find_by_name!("Solo (male)") }
      before(:create) do |team|
        team.riders << FactoryBot.build(:rider)
      end
    end

    factory :team_a do
      category { TeamCategory.find_by_name!("A Team") }
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
  end
end
