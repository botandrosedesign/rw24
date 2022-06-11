# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def fixed_number_or_empty(value, options = { :size => 2 })
    return '-' * options[:size] unless value.nonzero?
    "%0#{options[:size]}d" % value 
  end

  def start_time_format datetime
    return unless datetime
    string = datetime.strftime "%B %e-%%d, %Y | %l%P - %l%P"
    string % [datetime.day + 1]
  end

  def error_messages_for record
    count = record.errors.count
    if count > 0
      tag.div do
        tag.h2("#{pluralize count, "error"} prohibited this #{record.class.name} from being saved") +
        tag.p("There were problems with the following fields:") +
        tag.ul do
          record.errors.to_a.map do |message|
            tag.li(message)
          end.reduce(:+)
        end
      end
    end
  end
end
