require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.first_name { Faker::Name.first_name }
Sham.last_name { Faker::Name.last_name }
Sham.name { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.sentence { Faker::Lorem.sentence }
Sham.paragraph { Faker::Lorem.paragraph }
Sham.url { "http://#{Faker::Internet.domain_name}/#{Faker::Lorem.words(3).join('_').downcase}" }

Sham.address { Faker::Address.street_address }
Sham.city { Faker::Address.city }
Sham.state { Faker::Address.us_state }
Sham.zip { Faker::Address.zip_code }
Sham.phone { Faker::PhoneNumber.phone_number }

Site.blueprint do
  name { "Riverwest24" }
  host { "www.example.com" }
  title { "Riverwest24" }
  email { "micah@botandrose.com" }
end

User.blueprint do
  first_name
  last_name
  email
  homepage { Sham.url }
  password { "password" }
  verified_at { Time.zone.now }
end

Blog.blueprint do
  path { "blog" }
  permalink { "blog" }
  title { "Blog" }
  published_at { Time.zone.parse "2008-01-01" }
  comment_age { 0 }
end

Page.blueprint do
  path { "pages" }
  permalink { "pages" }
  title { "Pages" }
  published_at { Time.zone.parse "2008-01-01" }
  single_article_mode { false }
  comment_age { -1 }
end

Category.blueprint do
  title { Sham.name }
end

Article.blueprint do
  title { Sham.sentence }
  body { Sham.paragraph }
  published_at { Time.zone.parse "2008-01-01" }
  author { User.make }
end

Tag.blueprint do
  name { Sham.word }
end

Team.blueprint do
  name
  address
  city
  state
  zip
  phone
end

Rider.blueprint do
  name
  email
end
