module Menus
  module Admin
    # will be concatenated onto existing sites menu via javascript
    class Sites < Menu::Group
      define do
        namespace :admin
        menu :left, :class => 'main' do
          if current_race = Race.current
            item :current_race, action: :index, url: [:admin, current_race, :teams], type: CurrentRaceItem
          end
          item :races, action: :index, url: [:admin, :races], type: RacesItem
        end
      end
    end

    class CurrentRaceItem < Menu::Item
      def activate path
        self.active = path.starts_with?("/admin/races/#{Race.current.id}")
      end
    end

    class RacesItem < Menu::Item
      def activate path
        self.active = path.starts_with?("/admin/races")

        if current_race = Race.current
          self.active = false if path.starts_with?("/admin/races/#{current_race.id}")
        end
      end

      def active= value
        super if value === true
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
