require "ar_helper"
require "race"
require "team"
require "rider"
require "point"
require "bonus"
require "./spec/support/factories"

describe Race do
  before { Team.any_instance.stub(assign_site: nil) }
  before { stub_const "Site", double }

  describe "#assign_all_bonuses_bonuses" do
    subject do
      FactoryGirl.create(:race, bonuses: [
        { name: "tattoo", points: "5" },
        { name: "bonus 1", points: "2" },
        { name: "bonus 2", points: "2" },
        { name: "bonus 3", points: "2" },
        { name: "all bonuses", points: "5" },
      ])
    end

    let(:team) { FactoryGirl.create(:team_solo, name: "Han Solo") }

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
      -> { subject.assign_all_bonuses_bonuses }.should
        raise_error("The last bonus needs to be a five point all bonuses bonus")
    end

    it "complains if there is no tattoo bonus" do
      subject.bonuses.shift
      subject.save!
      -> { subject.assign_all_bonuses_bonuses }.should
        raise_error("The first bonus needs to be a five point tattoo bonus")
    end
  end
end
