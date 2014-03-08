class Album < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :cover, :class_name => 'Resource'
  belongs_to :user
  has_many :resources, :as => :resourcable, :dependent => :destroy

  scope :active, :conditions => {:approved => true}

  def toggle_approved
    self.approved = self.approved ? false : true
    self.save
  end
end
