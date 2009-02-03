class Item < ActiveRecord::Base
  belongs_to :parent,   :class_name => 'Item', :foreign_key => 'parent_id'
  has_many   :children, :class_name => 'Item', :foreign_key => 'parent_id'

  named_scope :ordered, :order => 'rank ASC'
  named_scope :with_children, :include => :children do
    def heads
      find_all_by_parent_id(nil)
    end
  end

  def level
    parent.nil? ? 0 : parent.level.next
  end
end
