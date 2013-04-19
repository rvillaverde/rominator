class ConsoleAsker

  def self.ask(question, response_type, validate, message)
    answer = ask_question(question, response_type)
    if (validate)
      until valid_response?(response_type, answer) do
        puts message
        answer = ask_question(question, response_type)
      end
    end
    extract_response(response_type, answer)
  end

private

  def self.ask_question(question, response_type)
    puts "#{question}\n#{response_type_leyend response_type}"
    gets.chomp
  end

  def self.valid_response?(response_type, response)
    case response_type
    when :string
      !response.empty?
    when :integer
      !response.empty?
    when :boolean
      response.downcase.start_with?('s') || response.downcase.start_with?('n')
    end
  end

  def self.extract_response(response_type, response)
    case response_type
    when :string
      response unless response.empty?
    when :integer
      response.to_i
    when :boolean
      response.downcase.start_with?('s')
    end
  end

  def self.response_type_leyend(response_type)
    case response_type
    when :integer
      "[Ingrese un numero]"
    when :boolean
      "[Contestar Si/No]"
    end
  end

end