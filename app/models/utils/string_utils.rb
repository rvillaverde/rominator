module Utils
  class StringUtils

  	def self.to_boolean(input)
  		if input.downcase == 'yes'
  			true
  		else input.downcase == 'no'
  			false
  		end
  	end

  end
end