# Conway's Game of Life without classes

def build_world x, y
	world = []

	x.times do
		row = []
		y.times do
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
	new_world = build_world world.count, world.first.count

	world.count.times do |row|
		world.first.count.times do |col|
			neighbors = find_neighbors(world, row, col)
			new_world[row][col] = transform_cell(world[row][col], neighbors)
		end
	end

	new_world
end

def find_neighbors world, x, y
	neighbors = 0

	(x-1..x+1).each do |row|
		(y-1..y+1).each do |col|
			if row > 0 && col > 0 && row < world.count && col < world.first.count
				neighbors += 1 if world[row][col] == 'alive' unless row == x && col == y
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

def print_world world
	world.count.times do |row|
		line = []
		world.first.count.times do |col|
			if world[row][col] == 'alive'
				line << 'X'
			else
				line << ' '
			end
		end
		puts "Line #{row}: \t#{line}"
	end
end


def game_of_life x, y, iterations
	world = build_world x, y
	world = seed_world(world, [11,8])
	world = seed_world(world, [11,9])
	world = seed_world(world, [12,9])
	world = seed_world(world, [10,10])
	world = seed_world(world, [12,10])

	world = seed_world(world, [3,4])
	world = seed_world(world, [4,4])
	world = seed_world(world, [5,4])


	puts "Initial state"
	print_world world
	iterations.times do |i|
		puts "Iteration #{i + 1}"
		world = transform_world world
		print_world world
	end
	world
end

#world = game_of_life 20, 20, 5
