require "ar_helper"
require "race"
require "team"
require "team_category"
require "rider"
require "point"
require "bonus"
require "support/factories"
load "db/seeds.rb"

describe Race do
  describe "#update_category" do
    let(:race) { FactoryBot.create(:race, year: 2026) }
    let(:category) { TeamCategory.find_by_name!("Solo (open)") }

    context "when the category is exclusive to this race" do
      before do
        race.update! category_ids: [category.id]
      end

      it "mutates the category in place" do
        expect {
          race.update_category(category, name: "Solo (Non-Binary)", initial: "N", min: 1, max: 1)
        }.not_to change(TeamCategory, :count)
        category.reload.name.should == "Solo (Non-Binary)"
      end

      it "keeps the same category ID in the race" do
        race.update_category(category, name: "Solo (Non-Binary)", initial: "N", min: 1, max: 1)
        race.reload.category_ids.should include(category.id)
      end
    end

    context "when the category is shared with another race" do
      let(:other_race) { FactoryBot.create(:race, year: 2025, category_ids: [category.id]) }

      before do
        other_race
        race.update! category_ids: [category.id]
      end

      it "creates a new category record" do
        expect {
          race.update_category(category, name: "Solo (Non-Binary)", initial: "N", min: 1, max: 1)
        }.to change(TeamCategory, :count).by(1)
      end

      it "replaces the old category ID with the new one in this race" do
        new_category = race.update_category(category, name: "Solo (Non-Binary)", initial: "N", min: 1, max: 1)
        race.reload.category_ids.should include(new_category.id)
        race.reload.category_ids.should_not include(category.id)
      end

      it "does not modify the original category" do
        race.update_category(category, name: "Solo (Non-Binary)", initial: "N", min: 1, max: 1)
        category.reload.name.should == "Solo (open)"
      end

      it "leaves the other race's categories unchanged" do
        race.update_category(category, name: "Solo (Non-Binary)", initial: "N", min: 1, max: 1)
        other_race.reload.category_ids.should include(category.id)
      end
    end
  end

  describe "#assign_all_bonuses_bonuses" do
    subject do
      FactoryBot.create(:race, bonuses: [
        { name: "tattoo", points: "5" },
        { name: "bonus 1", points: "2" },
        { name: "bonus 2", points: "2" },
        { name: "bonus 3", points: "2" },
        { name: "all bonuses", points: "5" },
      ])
    end

    let(:team) { FactoryBot.create(:team_solo, name: "Han Solo") }

    it "assigns the all bonuses bonus to teams that have attended every bonus" do
      Point.create! race: subject, team: team, category: "Bonus", qty: 2, bonus_id: 1
      Point.create! race: subject, team: team, category: "Bonus", qty: 2, bonus_id: 2
      Point.create! race: subject, team: team, category: "Bonus", qty: 2, bonus_id: 3
      team.bonuses_total.should == 6
      subject.assign_all_bonuses_bonuses
      team.points.reload
      team.bonuses_total.should == 11
      team.points.bonuses.map(&:bonus_id).should == [1,2,3,4]
    end

    it "does not assign the bonus to teams that have attended every bonus and have a tattoo" do
      Point.create! race: subject, team: team, category: "Bonus", qty: 5, bonus_id: 0
      Point.create! race: subject, team: team, category: "Bonus", qty: 2, bonus_id: 1
      Point.create! race: subject, team: team, category: "Bonus", qty: 2, bonus_id: 2
      Point.create! race: subject, team: team, category: "Bonus", qty: 2, bonus_id: 3
      team.bonuses_total.should == 11
      subject.assign_all_bonuses_bonuses
      team.bonuses_total.should == 11
      team.points.bonuses.map(&:bonus_id).should == [0,1,2,3]
    end

    it "does not assign the bonus to teams that have not attended every bonus" do
      Point.create! race: subject, team: team, category: "Bonus", qty: 2, bonus_id: 1
      Point.create! race: subject, team: team, category: "Bonus", qty: 2, bonus_id: 3
      team.bonuses_total.should == 4
      subject.assign_all_bonuses_bonuses
      team.bonuses_total.should == 4
      team.points.bonuses.map(&:bonus_id).should == [1,3]
    end

    it "complains if there is no all bonuses bonus" do
      subject.bonuses.pop
      subject.save!
      -> { subject.assign_all_bonuses_bonuses }.should \
        raise_error("The last bonus needs to be a five point all bonuses bonus")
    end

    it "complains if there is no tattoo bonus" do
      subject.bonuses.shift
      subject.save!
      -> { subject.assign_all_bonuses_bonuses }.should \
        raise_error("The first bonus needs to be a five point tattoo bonus")
    end
  end

  describe ".published" do
    it "returns only published races ordered by year desc" do
      published = FactoryBot.create(:race, year: 2024, published: true)
      unpublished = FactoryBot.create(:race, year: 2025, published: false)
      published2 = FactoryBot.create(:race, year: 2026, published: true)

      result = Race.published
      result.should include(published, published2)
      result.should_not include(unpublished)
      result.first.year.should == 2026
    end
  end

  describe ".current" do
    it "returns the last race" do
      FactoryBot.create(:race, year: 2024)
      latest = FactoryBot.create(:race, year: 2025)
      Race.current.should == latest
    end
  end

  describe "#running?" do
    let(:race) { FactoryBot.create(:race, start_time: start_time) }

    context "when race has started but not finished" do
      let(:start_time) { 1.hour.ago }

      it "returns true" do
        race.should be_running
      end
    end

    context "when race has not started" do
      let(:start_time) { 1.hour.from_now }

      it "returns false" do
        race.should_not be_running
      end
    end

    context "when race has finished" do
      let(:start_time) { 25.hours.ago }

      it "returns false" do
        race.should_not be_running
      end
    end
  end

  describe "#started?" do
    it "returns true when start_time is in the past" do
      race = FactoryBot.create(:race, start_time: 1.hour.ago)
      race.should be_started
    end

    it "returns false when start_time is in the future" do
      race = FactoryBot.create(:race, start_time: 1.hour.from_now)
      race.should_not be_started
    end
  end

  describe "#finished?" do
    it "returns true when 24 hours after start_time has passed" do
      race = FactoryBot.create(:race, start_time: 25.hours.ago)
      race.should be_finished
    end

    it "returns false when within 24 hours of start_time" do
      race = FactoryBot.create(:race, start_time: 1.hour.ago)
      race.should_not be_finished
    end
  end

  describe "#end_time" do
    it "returns start_time plus 24 hours" do
      start = Time.parse("2026-07-25 19:00:00 CDT")
      race = FactoryBot.create(:race, start_time: start)
      race.end_time.should == start + 24.hours
    end
  end

  describe "#bonuses" do
    it "returns empty array by default" do
      race = FactoryBot.create(:race)
      race.bonuses.should == []
    end

    it "returns stored bonuses" do
      race = FactoryBot.create(:race, bonuses: [{ "name" => "Test", "points" => "5" }])
      race.bonuses.length.should == 1
      race.bonuses.first["name"].should == "Test"
    end
  end

  describe "#bonuses=" do
    it "stores bonuses in settings" do
      race = FactoryBot.create(:race)
      race.bonuses = [{ "name" => "New", "points" => "3" }]
      race.save!
      race.reload.bonuses.first["name"].should == "New"
    end
  end

  describe "#bonus_checkpoints" do
    it "returns Bonus objects with sequential ids" do
      race = FactoryBot.create(:race, bonuses: [
        { "name" => "First", "points" => "5" },
        { "name" => "Second", "points" => "2" },
      ])
      checkpoints = race.bonus_checkpoints
      checkpoints.length.should == 2
      checkpoints.first.should be_a(Bonus)
      checkpoints.first.id.should == 0
      checkpoints.first.name.should == "First"
      checkpoints.last.id.should == 1
      checkpoints.last.name.should == "Second"
    end
  end

  describe "#total_laps" do
    it "sums lap quantities" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Lap", qty: 1
      Point.create! race: race, team: team, category: "Lap", qty: 1
      Point.create! race: race, team: team, category: "Bonus", qty: 5
      race.total_laps.should == 2
    end
  end

  describe "#total_miles" do
    it "multiplies total laps by 4.6" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Lap", qty: 1
      Point.create! race: race, team: team, category: "Lap", qty: 1
      race.total_miles.should == BigDecimal("9.2")
    end
  end

  describe "#shirt_size_counts" do
    before do
      stub_const "Site", double(first: nil)
    end

    it "aggregates shirt sizes across all teams" do
      race = FactoryBot.create(:race, shirt_sizes: %w[S M L])
      team1 = FactoryBot.create(:team_solo, race: race)
      team1.shirt_sizes = { "S" => "2", "M" => "1", "L" => "0" }
      team1.save!(validate: false)
      team2 = FactoryBot.create(:team_solo, race: race, name: "Team 2")
      team2.shirt_sizes = { "S" => "0", "M" => "3", "L" => "1" }
      team2.save!(validate: false)

      counts = race.shirt_size_counts
      counts["S"].should == 2
      counts["M"].should == 4
      counts["L"].should == 1
    end
  end

  describe "#other_race_uses_category?" do
    let(:category) { TeamCategory.find_by_name!("A Team") }

    it "returns true when another race uses the category" do
      race = FactoryBot.create(:race, year: 2025, category_ids: [category.id])
      other = FactoryBot.create(:race, year: 2026, category_ids: [category.id])
      race.other_race_uses_category?(category).should be true
    end

    it "returns false when no other race uses the category" do
      race = FactoryBot.create(:race, year: 2025, category_ids: [category.id])
      race.other_race_uses_category?(category).should be false
    end
  end
end
