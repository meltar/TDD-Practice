require "rspec"

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

def build_world x, y
	world = []

	y.times do
		row = []
		x.times do
			row << 'dead'
		end
		world << row
	end

	world
end

def seed_world world, cell
	new_world = world
	new_world[cell.first][cell.last] = 'alive'
	new_world
end

def transform_world world
	new_world = world

	world.count.times do |row|
		world.first.count.times do |column|
			neighbors = count_neighbors(world, row, column)
			new_world[row][column] = transform_cell(world[row][column], neighbors)
		end
	end

	new_world
end

def count_neighbors world, x, y
	neighbors = 0

	(x-1..x+1).each do |row|
		(y-1..y+1).each do |column|
			if row > 0 && column > 0 && row < world.count && column < world.first.count
				neighbors += 1 if world[row][column] == 'alive'
			end
		end
	end

	neighbors
end

def transform_cell status, neighbors
	if status == 'dead'
		new_status = transform_dead_cell neighbors
	else
		new_status = transform_living_cell neighbors
	end
end

def transform_living_cell neighbors
	neighbors == 3 || neighbors == 2 ? 'alive' : 'dead'
end

def transform_dead_cell neighbors
	neighbors == 3 ? 'alive' : 'dead'
end
