# This implementation of Conway's Game of Life is not supposed to be object oriented.

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
