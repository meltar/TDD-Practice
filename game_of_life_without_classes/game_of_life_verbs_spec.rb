require "rspec"
require "./game_of_life_verbs.rb"

describe "game of life:" do
	describe "build_world" do
		it "should take a length and width" do
			world = build_world(5,4)
			expect(world.first.count).to eq(5)
			expect(world.count).to eq(4)
		end	

		it "should start with all dead cells" do
			world = build_world(6,3)
			expect(world.first).to include('dead')
			expect(world.first).to_not include('alive')
		end
	end
	
	describe "seed_world" do
		it "should set the cells passed in as arguments as alive" do
			world = build_world(6,5)
			cell = [2,1]
			
			expect(world[2][1]).to eq('dead')
			seeded = seed_world(world, cell)
			expect(seeded[2][1]).to eq('alive')
		end

		it "should return a world that is the same dimensions as the argument" do
			world = build_world(5,4)
			cell = [1,1]

			seeded = seed_world(world, cell)
			expect(seeded.first.count).to eq(world.first.count)
			expect(seeded.count).to eq(world.count)
		end	
	end

	describe "transform_world" do
		it "should return a world that is the same dimensions as the argument" do
			world = build_world(5,4)

			transformed = transform_world(world)
			expect(transformed.first.count).to eq(world.first.count)
			expect(transformed.count).to eq(world.count)
		end	
	end

	describe "transform_cell" do
		context "a dead cell" do
			it "should become alive if it has exactly three live neighbors" do
				expect(transform_cell('dead', 3)).to eq('alive')
			end

			it "should stay dead if it has fewer or greater than three live neighbors" do
				expect(transform_cell('dead', 2)).to eq('dead')
				expect(transform_cell('dead', 4)).to eq('dead')
			end
		end

		context "a living cell" do
			it "should stay alive if it has exactly two or three neighbors" do
				expect(transform_cell('alive', 3)).to eq('alive')
				expect(transform_cell('alive', 2)).to eq('alive')
			end

			it "should die if it has fewer than two  or greater than three neighbors" do
				expect(transform_cell('alive', 4)).to eq('dead')
				expect(transform_cell('alive', 1)).to eq('dead')
			end
		end
	end

	describe "count_neighbors" do
		it "should return the total number of living neighbors" do
			world = build_world(5,5)
			expect(count_neighbors(world, 1, 3)).to eq(2)
		end
	end
end
