class Picture < ActiveRecord::Base
  has_attached_file :content,
                    :styles => { :medium => "150x150>",
                                 :thumb  => "50x50>" },
                    :url => "/images/:class/:id_:style_:basename.:extension",
                    :path => ":rails_root/public/images/:class/:id_:style_:basename.:extension"

  belongs_to :item
end
