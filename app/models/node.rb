class Node < ActiveRecord::Base

  attr_accessible :value, :index

  # Relations
  belongs_to :true_path, class_name: 'Node'
  belongs_to :false_path, class_name: 'Node'

  def self.index
    self.where(index: true).first
  end

  def add_child(node, path_type)
    if path_type
      self.true_path = node
    else
      self.false_path = node
    end
  end

  def has_next?
    true_path || false_path
  end

  def get_child(path_type)
    path_type ? true_path : false_path
  end

  def has_child?(value)
    true_path.value.downcase == value.downcase || false_path.value.downcase == value.downcase
  end

  def parent
    Node.first(:conditions => ['true_path_id = :id OR false_path_id = :id', :id => id])
  end

end