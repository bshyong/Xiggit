class SearchController < ApplicationController

layout 'application'


def index
	# @results = BookPost.find_with_index(params[:terms])
	 @results = BookPost.paginate_search params[:terms], :per_page => 5, :page => params[:page]
	 @book_bag = find_bag
	 
end


def search
  
end


require "rubygems"
require "xml"


def cbtest

end

def parse_xml

#ELEMENT_END = 15

doc = XML::Reader.file(ARGV[0], :options => XML::Parser::Options::NOBLANKS)

i = 1
while doc.read
    unless doc.node_type == ELEMENT_END
        puts "Node # #{i}"
        display doc
        i += 1
    end
end

doc.close

end


private

#display formatted name of a node
def display_name( node )
    puts "\tName: #{node.name}"
    if node.prefix
        puts "\t\tPrefix: #{node.prefix}" if node.prefix
        puts "\t\tLocal: #{node.local_name}"
    end
end

#display information about the attributes of a node
def display_attributes( node )
    node.attribute_count.times do | index |
        puts "Attribute # #{index + 1}"
        node.move_to_next_attribute
        display node
    end
    node.move_to_element
end

#display information about a node
def display( node )
    display_name node
    puts "\tDepth: #{node.depth}"
    puts "\tEmpty Element" if node.empty_element?
    puts "\tValue: #{node.value}" if node.has_value?
    display_attributes node
    print "\n"
end

end
