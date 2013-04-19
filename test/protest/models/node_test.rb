require "protest"
require "../test_helper"

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
    
    # it "should not allow to save a node if no index node already exists" do|

    # end
  end

end