require File.dirname(__FILE__) + '/../spec_helper'
require "rake"

describe "rake rw24:import" do
  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require "lib/tasks/rw24"
    Rake::Task.define_task(:environment)
  end

  it "imports the proper number of teams and riders" do
    @rake["rw24:import"].invoke
    Team.count.should == 109
    Rider.count.should == 298

    rider = Rider.find(1)
    rider.attributes.to_hash.reject { |k,v| %w(updated_at created_at).include?(k) }.symbolize_keys.should == {
      :id => 1,
      :name => "Troy Lucas",
      :team_id => 1,
      :shirt => "L",
      :paid => true,
      :payment_type => "cash",
      :email => "tlucas@wi.rr.com",
      :phone => "414-530-0424",
      :position => 1,
      :notes => nil,
      :confirmed_on => Date.parse("5/24/2010")
    }
    rider.team.attributes.to_hash.reject { |k,v| %w(updated_at created_at).include?(k) }.symbolize_keys.should == {
      :id => 1,
      :name => "T-Roy",
      :category => "Solo (male)",
      :address => nil,
      :line_2 => nil,
      :city => nil,
      :state => nil,
      :zip => nil
    }
    rider.team.riders.length.should == 1
    rider.team.captain.should == rider

    rider = Rider.find(8)
    rider.attributes.to_hash.reject { |k,v| %w(updated_at created_at).include?(k) }.symbolize_keys.should == {
      :id => 8,
      :name => "Meagan Schultz",
      :team_id => 3,
      :shirt => "L",
      :paid => true,
      :payment_type => "check 1535",
      :email => "meaganbasilius@gmail.com",
      :phone => nil,
      :position => 5,
      :confirmed_on => Date.parse("5/24/2010"),
      :notes => "initial confirmation email bounced back, follow up with phone call to verify?"
    }
    rider.team.attributes.to_hash.reject { |k,v| %w(updated_at created_at).include?(k) }.symbolize_keys.should == {
      :id => 3,
      :name => "Team Pubic Zirconia",
      :category => "B Team",
      :address => nil,
      :line_2 => nil,
      :city => nil,
      :state => nil,
      :zip => nil
    }
    rider.team.riders.length.should == 6
    rider.team.captain.should_not == rider
    rider.team.captain.should == Rider.find(4)

    Rider.find(45).should_not be_paid
  end
end
