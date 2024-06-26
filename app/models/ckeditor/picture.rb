class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    url: '/userfiles/image/:basename.:optional_style:extension',
                    path: ':rails_root/public/userfiles/image/:basename.:optional_style:extension',
                    styles: { content: '800>', thumb: '118x100#' }

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 2.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  def url_content
    url(:content)
  end
end

Paperclip.interpolates :optional_style do |attachment, style|
  style == :original ? "" : "#{style}."
end

