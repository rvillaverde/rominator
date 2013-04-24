class Node < ActiveRecord::Base

  attr_accessible :value, :index

  # Relations
  belongs_to :true_path, class_name: 'Node'
  belongs_to :false_path, class_name: 'Node'

  accepts_nested_attributes_for :true_path, :false_path

  # Validations
  validates_presence_of :value
  validate :there_is_only_one_index_node
  validate :is_leaf_or_has_two_children

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

private

  def there_is_only_one_index_node
    if self.index
      errors.add(:index, "There must be only one index node") unless Node.index.nil?
    # else
    #   errors.add(:index, "There must exist an index node") if Node.index.nil? || Node.index.id == self.id
    end
  end

  def is_leaf_or_has_two_children
    errors.add(:true_path, "There must be a child for the true path") if true_path.nil? && false_path
    errors.add(:false_path, "There must be a child for the false path") if true_path && false_path.nil?
  end

end