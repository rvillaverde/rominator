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
      return !response.empty?
    when :integer
      return !response.empty?
    when :boolean
      return response.downcase.start_with?('s') || response.downcase.start_with?('n')
    end
  end

  def self.extract_response(response_type, response)
    case response_type
    when :string
      return response unless response.empty?
    when :integer
      return response.to_i
    when :boolean
      return response.downcase.start_with?('s')
    end
  end

  def self.response_type_leyend(response_type)
    case response_type
    when :integer
      return "[Ingrese un numero]"
    when :boolean
      return "[Contestar Si/No]"
    end
  end

end