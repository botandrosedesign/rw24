require "ar_helper"
require "race"
require "team"
require "team_category"
require "rider"
require "point"
require "bonus"
require "support/factories"
load "db/seeds.rb"

describe Team do
  # stubbing #race is a bitch
  subject { FactoryBot.build(:team) }

  context "of category 'A Team'" do
    before { subject.category = TeamCategory.find_by_name("A Team") }

    [0,1,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    (2..6).each do |i|
      it "can have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should be_valid
      end
    end
  end

  context "of category 'B Team'" do
    before { subject.category = TeamCategory.find_by_name("B Team") }

    [0,1,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    (2..6).each do |i|
      it "can have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should be_valid
      end
    end
  end

  context "of category 'Solo (male)'" do
    before { subject.category = TeamCategory.find_by_name("Solo (male)") }

    [0,2,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    it "can have 1 riders" do
      subject.stub(riders: [double])
      subject.should be_valid
    end
  end

  context "of category 'Solo (female)'" do
    before { subject.category = TeamCategory.find_by_name("Solo (female)") }

    [0,2,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    it "can have 1 riders" do
      subject.stub(riders: [double])
      subject.should be_valid
    end
  end

  context "of category 'Tandem'" do
    before { subject.category = TeamCategory.find_by_name("Tandem") }

    [0,1,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    it "can have 2 riders" do
      subject.stub(riders: [double] * 2)
      subject.should be_valid
    end
  end

  describe "#shirt_sizes" do
    before do
      stub_const "Site", double(first: nil)
    end
    it "accepts a hash" do
      subject.shirt_sizes = {"small" => "1"}
      subject.shirt_sizes.small.should == 1
      subject.save(validate: false)
      subject.shirt_sizes.attributes.should == { "small" => 1 }
      subject.shirt_sizes.small.should == 1
    end
  end

  describe ".leader_board" do
    it "sorts teams by points_total descending" do
      race = FactoryBot.create(:race)
      team1 = FactoryBot.create(:team_solo, race: race, name: "Low")
      team2 = FactoryBot.create(:team_solo, race: race, name: "High")
      Point.create! race: race, team: team2, category: "Lap", qty: 1
      Point.create! race: race, team: team2, category: "Lap", qty: 1
      Point.create! race: race, team: team1, category: "Lap", qty: 1

      board = race.teams.leader_board
      board.first.should == team2
      board.last.should == team1
    end

    it "breaks ties by position (reversed)" do
      race = FactoryBot.create(:race)
      team1 = FactoryBot.create(:team_solo, race: race, name: "First")
      team2 = FactoryBot.create(:team_solo, race: race, name: "Second")

      board = race.teams.leader_board
      board.first.should == team2
      board.last.should == team1
    end
  end

  describe "#laps_total" do
    it "sums lap quantities" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Lap", qty: 1
      Point.create! race: race, team: team, category: "Lap", qty: 1
      Point.create! race: race, team: team, category: "Bonus", qty: 5
      team.laps_total.should == 2
    end
  end

  describe "#miles_total" do
    it "multiplies laps by 4.6" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Lap", qty: 1
      Point.create! race: race, team: team, category: "Lap", qty: 1
      team.miles_total.should == BigDecimal("9.2")
    end
  end

  describe "#bonuses_total" do
    it "sums bonus quantities" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Bonus", qty: 5, bonus_id: 0
      Point.create! race: race, team: team, category: "Bonus", qty: 2, bonus_id: 1
      Point.create! race: race, team: team, category: "Lap", qty: 1
      team.bonuses_total.should == 7
    end
  end

  describe "#penalties_total" do
    it "sums penalty quantities" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Penalty", qty: -3
      Point.create! race: race, team: team, category: "Penalty", qty: -2
      team.penalties_total.should == -5
    end
  end

  describe "#points_total" do
    it "sums all point quantities" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Lap", qty: 1
      Point.create! race: race, team: team, category: "Bonus", qty: 5, bonus_id: 0
      Point.create! race: race, team: team, category: "Penalty", qty: -2, bonus_id: 1
      team.points_total.should == 4
    end
  end

  describe "#captain" do
    it "returns the first rider" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_a, race: race)
      team.captain.should == team.riders.first
    end
  end

  describe "#captain_email" do
    it "returns the captain's email" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      team.captain_email.should == team.riders.first.email
    end
  end

  describe "#lieutenants" do
    it "returns all riders except the captain" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_a, race: race)
      team.lieutenants.should == team.riders[1..]
      team.lieutenants.should_not include(team.captain)
    end
  end

  describe "#lieutenant_emails" do
    it "returns comma-separated emails of non-captain riders" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_a, race: race)
      emails = team.lieutenants.collect(&:email).select(&:present?).join(", ")
      team.lieutenant_emails.should == emails
    end
  end

  describe "#category_initial" do
    it "delegates to category" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      team.category_initial.should == "S"
    end
  end

  describe "#category_name" do
    it "delegates to category" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      team.category_name.should == "Solo (male)"
    end
  end

  describe "#legacy_category_initial_with_gender" do
    it "returns E for elder categories" do
      race = FactoryBot.create(:race)
      team = FactoryBot.build(:team, race: race, category: TeamCategory.find_by_name!("Elder Team"))
      team.stub(riders: [double] * 2)
      team.legacy_category_initial_with_gender.should == "E"
    end

    it "returns F for Solo (female)" do
      race = FactoryBot.create(:race)
      team = FactoryBot.build(:team, race: race, category: TeamCategory.find_by_name!("Solo (female)"))
      team.stub(riders: [double])
      team.legacy_category_initial_with_gender.should == "F"
    end

    it "returns M for Solo (male)" do
      race = FactoryBot.create(:race)
      team = FactoryBot.build(:team, race: race, category: TeamCategory.find_by_name!("Solo (male)"))
      team.stub(riders: [double])
      team.legacy_category_initial_with_gender.should == "M"
    end

    it "returns the initial for non-solo non-elder categories" do
      race = FactoryBot.create(:race)
      team = FactoryBot.build(:team, race: race, category: TeamCategory.find_by_name!("A Team"))
      team.stub(riders: [double] * 2)
      team.legacy_category_initial_with_gender.should == "A"
    end
  end

  describe "#position_and_name" do
    it "returns position dash name" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race, name: "Speed Demons")
      team.position_and_name.should == "#{team.position} - Speed Demons"
    end
  end

  describe "#paid?" do
    it "returns true when all riders are paid" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_a, race: race)
      team.riders.each { |r| r.update!(paid: true) }
      team.should be_paid
    end

    it "returns false when any rider is unpaid" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_a, race: race)
      team.riders.first.update!(paid: true)
      team.riders.last.update!(paid: false)
      team.should_not be_paid
    end
  end

  describe "#partially_paid?" do
    it "returns true when some but not all riders are paid" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_a, race: race)
      team.riders.first.update!(paid: true)
      team.riders.last.update!(paid: false)
      team.should be_partially_paid
    end

    it "returns false when all riders are paid" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_a, race: race)
      team.riders.each { |r| r.update!(paid: true) }
      team.should_not be_partially_paid
    end

    it "returns false when no riders are paid" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_a, race: race)
      team.riders.each { |r| r.update!(paid: false) }
      team.should_not be_partially_paid
    end
  end

  describe "#emailed?" do
    it "returns true when confirmation_sent_at is present" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      team.update_column :confirmation_sent_at, Time.now
      team.should be_emailed
    end

    it "returns false when confirmation_sent_at is nil" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      team.should_not be_emailed
    end
  end

  describe "#has_bonus?" do
    it "returns true when team has the given bonus" do
      race = FactoryBot.create(:race, bonuses: [{ "name" => "Test", "points" => "5" }])
      team = FactoryBot.create(:team_solo, race: race)
      bonus = race.bonus_checkpoints.first
      Point.create! race: race, team: team, category: "Bonus", qty: 5, bonus_id: bonus.id
      team.has_bonus?(bonus).should be true
    end

    it "returns false when team does not have the bonus" do
      race = FactoryBot.create(:race, bonuses: [{ "name" => "Test", "points" => "5" }])
      team = FactoryBot.create(:team_solo, race: race)
      bonus = race.bonus_checkpoints.first
      team.has_bonus?(bonus).should be false
    end
  end

  describe "#allowed_range" do
    it "delegates to category" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      team.allowed_range.should eq(1..1)
    end
  end

  describe "#to_paypal_hash" do
    it "returns correct PayPal parameters" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      hash = team.to_paypal_hash
      hash[:business].should == "riverwest24@gmail.com"
      hash[:amount].should == 20.00
      hash[:quantity].should == team.riders.length
      hash[:item_name].should include(team.category.name)
      hash[:custom].should == team.id
      hash[:currency_code].should == "USD"
    end
  end

  describe "#assign_phone_to_captain" do
    it "assigns team phone to captain on save" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      team.phone = "555-1234"
      team.save!
      team.captain.phone.should == "555-1234"
    end
  end

  describe "#race_year" do
    it "delegates year to race" do
      race = FactoryBot.create(:race, year: 2025)
      team = FactoryBot.create(:team_solo, race: race)
      team.race_year.should == 2025
    end
  end

  describe ".by_category" do
    it "filters teams by category" do
      race = FactoryBot.create(:race)
      solo = FactoryBot.create(:team_solo, race: race, name: "Solo")
      a_team = FactoryBot.create(:team_a, race: race, name: "A Team")

      Team.by_category(solo.category).should include(solo)
      Team.by_category(solo.category).should_not include(a_team)
    end
  end
end
