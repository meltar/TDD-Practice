class StringCalculator

	def add numbers
		delimiters = [",", "\n"]
		if numbers.include?("//")
			array = numbers.split("[")
			delimiters << array[1].split("]").first

			numbers = array.last.split("]").first
			numbers = "" unless numbers
		end

		total numbers, delimiters
	end

	private

	def total numbers, delimiters
		negative_numbers = []
		total = 0
		if found_any_match? numbers, delimiters
			values = numbers.split(/#{delimiters}/).map { |i| i.to_i }
			two_numbers = values.take(2)
			total = two_numbers.inject(:+)
		elsif !numbers.empty?
			if numbers.to_i < 0
				negative_numbers << numbers.to_i
			end
			total = numbers.to_i
		end

		raise StandardError::ArgumentError, "Negatives not allowed: #{negative_numbers}" unless negative_numbers.empty?
		total
	end

	def found_any_match? numbers, delimiters
		found = false
		delimiters.each { |delimiter| found = true if numbers.include?(delimiter) }
		found
	end

end
