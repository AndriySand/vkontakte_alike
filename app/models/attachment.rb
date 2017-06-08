class Attachment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :article
  belongs_to :attachable, polymorphic: true
  validates :attachable_id, :attachable_type, :author_id, presence: true
  has_attached_file :asset, default_url: ":style/missing.jpg", styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :asset, content_type: /\A(image|application|text|audio)\/.*\z/
  before_post_process :skip_for_not_images

  def skip_for_not_images
    ! %w(audio/ogg application/ogg application/vnd.ms-excel application/msword text/html audio/mp3).include?(asset_content_type)
  end
end
