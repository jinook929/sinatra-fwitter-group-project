class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true

  def slug
    self.content.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|obj| obj.slug == slug}
  end
end
