class NodesController < ApplicationController
  before_filter :clean_session, except: [:new, :create]

  def index
    @index_node = Node.index
  end

  def new
    @last_node = session[:last_node]
    @new_node = Node.new
    @new_node.initialize_children
  end

  def create
    @last_node = session[:last_node]
    parent_node = @last_node.parent

    true_path = params[:node][:true_path_attributes][:value]
    false_path = params[:node][:false_path_attributes][:value]

    @new_node = Node.new(value: params[:node][:value])

    if @last_node.value.downcase == true_path.downcase
      @new_node.add_child(@last_node, true)
      @new_node.build_false_path(value: false_path)
    elsif @last_node.value.downcase == false_path.downcase
      @new_node.build_true_path(value: true_path)
      @new_node.add_child(@last_node, false)
    end

    if @new_node.has_next?
      parent_node.add_child(@new_node, session[:last_answer])
    else
      @new_node.initialize_children(true_path, false_path)
      @new_node.true_path.errors.add(:value, "#{@last_node.value} must be one of the answers")
      @new_node.false_path.errors.add(:value, "#{@last_node.value} must be one of the answers")
      render :new
      return
    end

    @index_node = Node.index
    if parent_node.save
      flash[:notice] = "Has agregado un nuevo personaje!"
      render :index
    else
      flash[:notice] = "Ha ocurrido un error agregando tu personaje."
      render :index
    end
  end

  def show
    @node = find_node params[:id]
  end

  def next
    @last_answer = params[:answer]
    @parent_node = find_node params[:node_id]
    @node = @parent_node.get_child(Utils::StringUtils.to_boolean @last_answer)

    unless @node.has_next?
      update_session(@last_answer, @node)
    end

    render :show
  end

private

  def clean_session
    session[:last_answer] = nil
    session[:last_node_id] = nil
  end

  def update_session(last_answer, last_node)
    # Save these variables to session to avoid hacking in case of adding a new character
    session[:last_answer] = Utils::StringUtils.to_boolean last_answer
    session[:last_node] = last_node
  end

  def find_node(id)
    Node.find(id)
  end

end
