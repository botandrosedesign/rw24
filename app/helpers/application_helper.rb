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
end
