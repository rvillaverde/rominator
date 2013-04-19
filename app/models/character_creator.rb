class CharacterCreator

  attr_reader :current_node
  attr_reader :last_answer

  def initialize(current_node, last_answer)
    @current_node = current_node
    @last_answer = last_answer
  end

  def start
    puts "Vamos a agregar un nuevo personaje, recuerde que #{current_node.value} debe ser una de las respuestas"
    prompt_new_node
  end

private

  def prompt_new_node
    new_node = nil
    until new_node do
      question = ask("Ingrese la nueva pregunta:", "Por favor, ingrese una pregunta valida.")
      true_path = ask("Ingrese el nombre del personaje para la respuesta verdadera:", "Por favor, ingrese un personaje.")
      false_path = ask("Ingrese el nombre del personaje para la respuesta false:", "Por favor, ingrese un personaje.")

      new_node = get_new_node(question, true_path, false_path)
      puts "Ninguna de tus respuestas es #{current_node.value}, por favor, ingrese una respuesta valida." unless new_node
    end

    create_character(new_node)
    puts "Has ingresado un nuevo personaje!"
  end

  def ask(question, message)
    ConsoleAsker.ask(question, :string, true, message)
  end

  def get_new_node(question, true_path, false_path)
    new_node = Node.new(value: question)

    true_path == current_node.value ? 
                  new_node.add_child(current_node, true) : 
                  new_node.build_true_path(value: true_path)
    false_path == current_node.value ? 
                  new_node.add_child(current_node, false) : 
                  new_node.build_false_path(value: false_path)

    return new_node if new_node.has_child?(current_node.value)
  end

  def create_character(new_node)
    parent_node = current_node.parent
    parent_node.add_child(new_node, last_answer)
    parent_node.save
  end

end
