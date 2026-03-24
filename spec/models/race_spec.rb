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
end
