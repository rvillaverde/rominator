class RominatorApp

  attr_reader :current_node
  attr_reader :last_answer

  def play
    @current_node = Node.index

    while current_node.has_next? do
      @last_answer = ask_question(current_node.value)
      next_step(last_answer)
    end

    puts "Usted penso en: #{current_node.value}"
    validate_response
  end

private

  def ask_question(question)
    ConsoleAsker.ask(question, :boolean, true, "Por favor ingrese una respuesta correcta.")
  end

  def next_step(answer)
    @current_node = current_node.get_child(answer)
  end

  def validate_response
    answer = ask_question("Es cierto?")
    if answer
      puts "Soy una genia! =)"
    else
      add_new_character
    end
  end

  def add_new_character
    CharacterCreator.new(current_node, last_answer).start
  end

end