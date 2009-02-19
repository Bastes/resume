class Item < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :rank, :on => :update

  belongs_to :parent,   :class_name => 'Item', :foreign_key => 'parent_id'
  has_many   :children, :class_name => 'Item', :foreign_key => 'parent_id',
             :dependent => :destroy, :order => 'rank ASC'
  has_many   :pictures, :dependent => :destroy

  named_scope :ordered, :order => 'rank ASC'
  named_scope :with_children, :include => :children do
    def heads
      find_all_by_parent_id(nil)
    end
  end

  def level
    parent.nil? ? 0 : parent.level.next
  end

  def before_create
    previous = self.class.find(:first,
                               :conditions => { :parent_id => self.parent_id },
                               :order => 'rank DESC')
    if previous
      self.rank = previous.rank.next
    else
      self.rank = 1
    end
  end

  def before_save
    if self.rank_changed?
      direction = self.rank_was <=> self.rank;
      rank_rng = direction == 1 ? ((self.rank)..(self.rank_was - 1)) :
                                  ((self.rank_was + 1)..(self.rank))
      self.class.update_all "rank = rank + (#{direction})",
                            { :parent_id => self.parent_id, :rank => rank_rng }
    end
  end
end
