require "protest"
require (File.dirname(File.realdirpath(__FILE__)) + '/../../test_helper.rb')
# require "../../test_helper.rb"

Protest.describe("A Node") do

  setup do
    @index_node = Node.new(value: "Is your character male?", index: true)
    @true_node = Node.new(value: "yourself")
    @false_node = Node.new(value: "yourself")
  end

  context "when creating" do
    it "validates value" do
      @index_node.value = nil
      assert !@index_node.valid?
    end

    it "validates a node cannot have only one child" do
      @index_node.true_path = @true_node
      assert !@index_node.valid?

      @index_node.true_path = nil
      @index_node.false_path = @false_node
      assert !@index_node.valid?
    end

    it "should not allow to save a new index node if there's another index node" do
      @index_node.save
      @new_index_node = Node.new(value: "Another index", index: true)
      assert !@new_index_node.valid?
    end

    it "should find the children's parent correctly" do
      @index_node.add_child(@true_node, true)
      @index_node.add_child(@false_node, false)
      @index_node.save!
    end

    it "should add a node between two nodes correctly" do
      @index_node.save
      new_node = Node.new
    end
  end

  teardown do
    @index_node.destroy
  end

end