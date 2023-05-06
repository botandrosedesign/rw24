module Menus
  module Admin
    # will be concatenated onto existing sites menu via javascript
    class Sites < Menu::Group
      define do
        namespace :admin
        menu :left, :class => 'main' do
          if current_race = Race.last
            item :current_race, content: link_to("Current Race", [:admin, current_race, :teams])
          end
          item :races, content: link_to("Races", [:admin, :races])
        end
      end
    end

    class Teams < Menu::Group
      define do
        id :main
        parent Sites.new.build(scope).find(:races)
        menu :left, class: "left"

        menu :actions, :class => 'actions' do
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
    end

    class Races < Menu::Group
      define do
        id :main
        parent Sites.new.build(scope).find(:races)
        menu :left, class: "left"

        menu :actions, :class => 'actions' do
          item :new_race, :content => link_to_current("New Race", [:new, :admin, :race])
        end
      end
    end
  end
end
