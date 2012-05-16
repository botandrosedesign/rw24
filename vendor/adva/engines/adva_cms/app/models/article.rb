class Article < Content
  # default_scope :order => "#{self.table_name}.published_at DESC"

  filters_attributes :except => [:excerpt, :excerpt_html, :body, :body_html, :cached_tag_list]

  validates_presence_of :title, :body
  validates_uniqueness_of :permalink, :scope => :section_id

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

  def primary?
    self == section.articles.primary
  end

  def previous
    section.articles.published(:conditions => ["#{self.class.table_name}.published_at < ?", published_at], :limit => 1).first
  end

  def next
    section.articles.published(:conditions => ["#{self.class.table_name}.published_at > ?", published_at], :limit => 1).first
  end

  def has_excerpt?
    return false if excerpt == "<p>&#160;</p>" # empty excerpt with fckeditor
    excerpt.present?
  end

  def full_permalink
    raise "cannot create full_permalink for an article that belongs to a non-blog section" unless section.is_a?(Blog)
    # raise "can not create full_permalink for an unpublished article" unless published?
    date = [:year, :month, :day].map { |key| [key, (published? ? published_at : created_at).send(key)] }.flatten
    Hash[:permalink, permalink, *date]
  end

  def next_article
    section.articles.published.first :conditions => "published_at <= '#{published_at}' AND id != #{id}"
  end

  def previous_article
    section.articles.published.first :conditions => "published_at >= '#{published_at}' AND id != #{id}", :order => "published_at ASC"
  end
end
