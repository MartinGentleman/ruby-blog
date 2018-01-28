# create_table "images", force: :cascade do |t|
#    t.string   "image_file_name"
#    t.string   "image_content_type"
#    t.integer  "image_file_size"
#    t.datetime "image_updated_at"
#    t.datetime "created_at",         null: false
#    t.datetime "updated_at",         null: false
#    t.integer  "album_id"
#  end
#
#  add_index "images", ["album_id"], name: "index_images_on_album_id"
class Image < ActiveRecord::Base
  self.table_name = :images
  
  belongs_to :album
  has_one :web_page, :dependent => :nullify
  
  has_attached_file :image,
    :styles => { :medium => "400x400>", :rectangle => "400x225#", :square => "400x400#", :thumb => "100x100#" },
    :convert_options => { :all => "-gravity Center" }

  validates :image_file_name, presence: true 
  # because http://stackoverflow.com/questions/21897725/papercliperrorsmissingrequiredvalidatorerror-with-rails-4
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  delegate :url, :to => :image
  alias_attribute :link, :url
  
  def serializable_hash(options = nil)
    options ||= {}
    options[:methods] ||= []
    #options[:methods] << :url
    options[:methods] << :link
    super(options)
  end
  
  scope :image_links, -> { select(:image_file_name, :id) }
  
end
