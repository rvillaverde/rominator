class NodesController < ApplicationController
  
  def index
    @index_node = Node.index
  end

  def new
    @last_node = find_node params[:node_id]
    @last_answer = params[:last_answer]
  end

  def create
    last_answer = Utils::StringUtils.to_boolean params[:last_answer]
    last_node = find_node params[:last_node_id]
    parent_node = last_node.parent

    true_path = params[:node][:true_path]
    false_path = params[:node][:false_path]

    new_node = Node.new(value: params[:node][:value])

    if last_node.value.downcase == true_path.downcase
      new_node.add_child(last_node, true)
      new_node.build_false_path(value: false_path)
    else
      new_node.build_true_path(value: true_path)
      new_node.add_child(last_node, false)
    end
    parent_node.add_child(new_node, last_answer)

    @index_node = Node.index
    if parent_node.save
      render :index, :notice => "Has agregado un nuevo personaje!"
    else
      render :index, :notice => "Ha ocurrido un error agregando tu personaje."
    end
  end

  def show
    @node = find_node params[:id]
  end

  def next
    @last_answer = params[:answer]
    @parent_node = find_node params[:node_id]
    @node = @parent_node.get_child(Utils::StringUtils.to_boolean @last_answer)
    render :show
  end

private

  def find_node(id)
    Node.find(id)
  end

end
