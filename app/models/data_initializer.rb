class DataInitializer

  attr_reader :index_node

  def initialize

  end

private

  def set_index_node
    @index_node = Node.new("Es hombre?", Node.new("Usted mismo"), Node.new("Usted misma"))
  end

end