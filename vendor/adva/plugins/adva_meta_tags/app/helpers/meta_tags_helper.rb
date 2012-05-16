module MetaTagsHelper
  DEFAULT_FIELDS = %w(author geourl copyright keywords description)

  def meta_tags(resource=nil)
    if current_resource = controller.try(:current_resource)
      # TODO: might want to activate meta tagging for sections?
      resource ||= current_resource unless current_resource.is_a?(Section)
    end
    resource ||= @site

    # TODO: check if we actually need this fallback
    fields = resource.class.try(:meta_fields) || DEFAULT_FIELDS

    DEFAULT_FIELDS.map do |name|
      resource = resources.find do |r|
        r.respond_to?(:"meta_#{name}")
      end

      meta_tag(name, resource.send(:"meta_#{name}")) if resource
    end.join("\n").html_safe
  end

  def meta_tag(name, content)
    tag 'meta', :name => name, :content => content
  end

  def meta_value_from(*args)
    args.detect { |arg| arg.present? }
  end
end
