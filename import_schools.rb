columns = [:name]
values = []

file = "universities.txt"

	File.open( file ) do |io|
			io.each {|line| line.chomp! ; values << line }
		end
		
		file2 = "commcolleges.txt"
		
			File.open( file2 ) do |io|
			io.each {|line| line.chomp! ; values << line }
		end
		
School.import columns, values, :on_duplicate_key_update => [:name]

################

def add_schools
columns = [:name]
values = []

file = "universities.txt"

	File.open( file ) do |io|
			io.each {|line| line.chomp! ; values << line }
		end
		
		file2 = "commcolleges.txt"
		
			File.open( file2 ) do |io|
			io.each {|line| line.chomp! ; values << line }
		end
		
		values.each do |v|
		  School.create(:name => v.to_s)
  end
		  
#School.import columns, values, :on_duplicate_key_update => [:name]


end
