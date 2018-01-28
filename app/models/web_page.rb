# create_table "web_pages", force: :cascade do |t|
#    t.string   "title"
#    t.text     "content"
#    t.datetime "published_at"
#    t.datetime "created_at",   null: false
#    t.datetime "updated_at",   null: false
#    t.string   "path"
#    t.integer  "image_id"
#    t.text     "summary"
#    t.string   "language",     default: "en", null: false
#    t.integer  "site_id",                     null: false
#  end
#
#  add_index "web_pages", ["image_id"], name: "index_web_pages_on_image_id"
#  add_index "web_pages", ["language"], name: "index_web_pages_on_language"
#  add_index "web_pages", ["path"], name: "index_web_pages_on_path", unique: true
#  add_index "web_pages", ["site_id"], name: "index_web_page_on_site_id"
#  add_index "web_pages", ["title"], name: "index_web_pages_on_title", unique: true


class WebPage < ActiveRecord::Base
  has_many   :web_page_dynamic_menu, :dependent => :destroy
  has_many   :web_page_tags, :dependent => :destroy
  has_many   :tags, :through => :web_page_tags
  belongs_to :site
  
  belongs_to :image
  
  validates  :title, presence: true,
                     length: { minimum: 3 }
  validates  :path, presence: true,
                    length: { minimum: 3 }
  validates  :site_id, presence: true
                    
  validates_uniqueness_of :title, :scope => :site_id
  validates_uniqueness_of :path, :scope => :site_id         
           
  before_validation :input_cleaner
  
  def input_cleaner
    self.title = ActionController::Base.helpers.sanitize(self.title, tags: [])
    self.summary = ActionController::Base.helpers.sanitize(self.summary, tags: [])
    self.path = ActionController::Base.helpers.sanitize(self.path, tags: [])
    self.path = self.path.gsub(' ', '-').downcase
    self.path = URI.encode(self.path)
    self.language = (%w(en cs).include? self.language) ? self.language : 'en'
  end

  scope :published, -> { where('published_at <= ?', Time.now) }
  scope :unpublished, -> { where('published_at > ?', Time.now) }
  scope :scheduled, -> { where('published_at IS NOT NULL and published_at > ?', Time.now) }
  scope :unscheduled, -> { where('published_at IS NULL') }
  scope :ordered, -> { order('published_at DESC, created_at DESC') }
  scope :ordered_with_nulls, -> { order('published_at IS NULL DESC, published_at DESC, created_at DESC') }
  scope :with_a_tag, ->(tag_id) { joins(:tags).where('tags.id = ?', tag_id) }
  scope :language, ->(locale) { where('language = ?', locale) }
  
  def published?
    self.published_at && self.published_at <= Time.now
  end
  def unpublished?
    self.published_at.nil? || self.published_at > Time.now
  end
  def scheduled?
    self.published_at && self.published_at > Time.now
  end
  def unscheduled?
    self.published_at.nil?
  end
end
