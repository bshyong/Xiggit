columns = [:name]
values = []

file = "universities.txt"

	File.open( file ) do |io|
			io.each {|line| line.chomp! ; values << line }
		end
		
		
School.import columns, values, :on_duplicate_key_update => [:name]