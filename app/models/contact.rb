class Contact < ActiveRecord::Base
  validates_presence_of :kind
  validates_presence_of :rank, :on => :update

  named_scope :ordered, :order => 'rank ASC'

  def before_create
    previous = self.class.find(:first, :order => 'rank DESC')
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
                            { :rank => rank_rng }
    end
  end
end
