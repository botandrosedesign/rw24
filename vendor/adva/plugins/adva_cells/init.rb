config.middleware.use "OutputFilter::Cells"

config.to_prepare do
  # FIXME this really should go somewhere else ... why did we put it here in the first place?
  class Cell::Base
    class << self
      # convert a cell to xml
      def to_xml(options={})
        options[:root]    ||= 'cell'
        options[:indent]  ||= 2
        options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])

        cell_name = self.to_s.gsub('Cell', '').underscore

        options[:builder].tag!(options[:root]) do |cell_node|
          cell_node.id   cell_name
          cell_node.name I18n.translate(:"adva.cells.#{cell_name}.name", :default => cell_name.humanize)
          cell_node.states do |states_node|
            self.action_methods.uniq.each do |state|
              states_node.state do |state_node|
                state = state.to_s

                # render the form ... if it's empty ... well, then it's empty ;-)
                # view = Cell::View.new
                # template = self.find_class_view_for_state(state + '_form').each do |path|
                #   puts path
                #   if template = view.try_picking_template_for_path(path)
                #     puts template
                #     return template
                #   end
                # end
                # form = template ? ERB.new(view.render(:template => template)).result : ''

                # FIXME: this implementation is brittle at best and needs to be refactored/corrected ASAP!!!
                # possible_templates = Dir[RAILS_ROOT + "/app/cells/#{cell_name}/#{state}_form.html.erb"] + Dir[File.join(RAILS_ROOT, 'vendor', 'adva', 'engines') + "/*/app/cells/#{cell_name}/#{state}_form.html.erb"] +
                #  Dir[File.join(RAILS_ROOT, 'vendor', 'adva', 'plugins') + "/*/app/cells/#{cell_name}/#{state}_form.html.erb"]
                possible_templates = Dir[RAILS_ROOT + "/app/cells/#{cell_name}/#{state}_form.html.erb"] + Dir[File.join(RAILS_ROOT, 'vendor', 'plugins') + "/*/app/cells/#{cell_name}/#{state}_form.html.erb"]
                template = possible_templates.first
                form = template ? ERB.new(File.read(template)).result : ''

                state_node.id          state
                state_node.name        I18n.translate(:"adva.cells.#{cell_name}.states.#{state}.name", :default => state.humanize)
                state_node.description I18n.translate(:"adva.cells.#{cell_name}.states.#{state}.description", :default => '')
                state_node.form        form
              end
            end
          end
        end
      end
    end
  end
end
