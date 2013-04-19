class Node < ActiveRecord::Base

  # attr_reader :value
  # attr_reader :true_path
  # attr_reader :false_path

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
    !true_path.nil? && !false_path.nil?
  end

  def get_child(path_type)
    path_type ? true_path : false_path
  end

  def has_child?(value)
    true_path.value.downcase == value.downcase || false_path.value.downcase == value.downcase
  end

  def parent
    Node.where('true_path_id = :id or false_path_id = :id', id: id).first
  end

# private

#   def set_true_path(node)
#     @true_path = node
#   end

#   def set_false_path(node)
#     @false_path = node
#   end

end