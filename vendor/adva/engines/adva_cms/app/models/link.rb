class Link < Content
  filters_attributes :except => [:excerpt, :excerpt_html, :body, :body_html, :cached_tag_list]

  validates_presence_of :title, :body

  class << self
    def find_by_permalink(*args)
      options = args.extract_options!
      permalink = args.pop
      if args.present?
        published(*args).find_by_permalink(permalink, options)
      else
        find :first, options.merge(:conditions => ["#{self.table_name}.permalink = ?", permalink])
      end
    end
  end

end
