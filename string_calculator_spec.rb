require_relative "./string_calculator"
require 'rspec'

describe "string_calculator" do
	let(:calculator)								{ StringCalculator.new }
	let(:no_numbers)								{ "" }
	let(:one_number)								{ "11" }
	let(:two_numbers)								{ "1,5" }
	let(:two_numbers_sum)						{ 6 }
	let(:three_numbers)							{ "1,5,8" }
	let(:new_line_numbers)					{ "1\n5\n8" }
	let(:custom_delimiter_three_numbers)	{ "//[;]\n[1;5,8]" }
	let(:custom_delimiter_one_number)			{ "//[o]\n[#{one_number}]" }
	let(:custom_delimiter_no_numbers)			{ "//[o]\n[]" }
	let(:negative_number)						{ "-11" }
	let(:negative_in_two_numbers)		{ "1,-5" }

	describe "the method 'add'" do

		it "can be called" do
			expect(calculator).to respond_to(:add)
			calculator.add(no_numbers)
		end

		it "returns 0 when the argument is empty" do
			expect(calculator.add(no_numbers)).to eq(0)
		end

		it "returns the number when the argument contains one number" do
			expect(calculator.add(one_number)).to eq(one_number.to_i)
		end

		context "with the default delimiters: ',' and '\n'" do
			it "returns the sum when the argument contains two numbers separated by a comma" do
				expect(calculator.add(two_numbers)).to eq(two_numbers_sum)
			end

			it "returns the sum when the argument contains two numbers separated by a new line" do
				expect(calculator.add(new_line_numbers)).to eq(two_numbers_sum)
			end

			it "only returns the sum of the first two numbers in a list" do
				expect(calculator.add(three_numbers)).to eq(two_numbers_sum)
			end
		end

		context "with a custom delimiter provided in the argument" do
			it "returns the sum when the argument contains two numbers separated by a delimiter" do
				expect(calculator.add(custom_delimiter_three_numbers)).to eq(two_numbers_sum)
			end

			it "behaves normally when there are fewer than two numbers" do
				expect(calculator.add(custom_delimiter_one_number)).to eq(one_number.to_i)
				expect(calculator.add(custom_delimiter_no_numbers)).to eq(0)
			end
		end

		context "with negative numbers in the argument" do
			it "should throw an exception 'negatives not allowed' with negative number(s)" do
				expect(calculator).to raise_error
				calculator.add(negative_number)
			end

			it "should display all negative numbers in the exception" do
				expect(calculator).to raise_error
				calculator.add(negative_in_two_numbers)
			end
		end
	end

end

