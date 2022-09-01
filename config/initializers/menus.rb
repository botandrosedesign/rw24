module Menus
  module Admin
    # will be concatenated onto existing sites menu via javascript
    class Sites < Menu::Group
      define do
        namespace :admin
        menu :left, :class => 'main' do
          item :races, content: link_to("Races", [:admin, :races])
        end
      end
    end

    class Teams < Menu::Group
      define do
        id :main
        parent Sites.new.build(scope).find(:races)
        menu :left, :class => 'left', :type => Teams::Races

        menu :actions, :class => 'actions' do
          if @teams
            item :database, content: link_to("Download Database", admin_database_path(format: :sql))
            item :export, :content => link_to("Export Teams", admin_race_teams_path(@race, :format => :csv))
            item :settings, :content => link_to("Edit Race", [:edit, :admin, @race])
          end
          item :new_race, :content => link_to_current("New Race", [:new, :admin, :race])
          if @team or @teams
            item :new, :content => link_to_current("New Team", [:new, :admin, @race, :team])
            if @team and !@team.new_record?
              item :delete, :content => link_to("Delete Team", [:admin, @race, @team], :method => :delete)
            end
          elsif @rider and !@rider.new_record?
            item :delete, :content => link_to("Delete Rider", [:admin, @race, @team, @rider], :method => :delete)
          end
        end
      end

      class Races < Menu::Menu
        define do
          Race.all.each do |race|
            item race.year.to_s, :content => link_to_current(race.year, [:admin, race, :teams], :if => @race == race)
          end
        end
      end
    end
  end
end
