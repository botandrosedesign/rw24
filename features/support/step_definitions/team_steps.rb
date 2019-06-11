Given /^a solo team exists with name: "(.*?)"$/ do |name|
  FactoryBot.create :team_solo, name: name
end

Given /^a solo team exists with name: "(.*?)", rider name: "(.+?)"$/ do |name, rider_name|
  FactoryBot.create :team, category: TeamCategory.find_by_name("Solo (male)"), name: name, riders: [FactoryBot.build(:rider, name: rider_name)]
end

Given /^a team exists with name: "(.*?)"$/ do |name|
  FactoryBot.create :team_a, name: name
end

Given /^the following race teams exist:/ do |table|
  table.create! factory_bot: :team do
    underscore_keys

    field(:race) { Race.last }

    rename :pos => :position

    belongs_to({ :class => :category }, TeamCategory)

    transformation do |attributes|
      def rider_from_email email, **attrs
        FactoryBot.attributes_for(:rider, email: email, **attrs) if email.present?
      end

      attributes.merge(riders_attributes: [
        rider_from_email(attributes.delete(:leader_email), name: attributes.delete(:leader_name), phone: attributes.delete(:leader_phone)),
        rider_from_email(attributes.delete(:rider_1_email)),
        rider_from_email(attributes.delete(:rider_2_email)),
      ].compact)
    end

    field(:shirt_sizes) do |value|
      if value.present?
        if value == "MM, MM, MM"
          ShirtSizes.new(mens_medium: 3)
        else
          raise NotImplementedError
        end
      end
    end
  end
end

Then "I should see the following teams:" do |table|
  table.diff!
end

Then /^I should see (\d+|no) teams?$/ do |count|
  if %w(0 no).include? count
    page.should_not have_css("table.list tbody tr")
  else
    page.should have_css("table.list tbody tr", count: count.to_i)
  end
end

