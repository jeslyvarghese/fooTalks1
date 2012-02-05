require 'murmur.rb'

bloom_filter = Array.new

set = ['hello','hi','fooTalks','CSI','margarita','vaccation']
seed = 56.to_i

set.each do
	|element|
	index = Digest::murmur_hash2(element.to_s,seed)%10
	bloom_filter[index]= true
end
print "Set:"
puts set
print "\n*************************\n"
print "Bloom Filter:"
bloom_filter.each{|element| print "[#{element}]"}
print "\n*************************\n"
check_set = ['hello','rajagiri','creativity','anna','CSI','margarita']
print "Check Set:"
puts check_set
print "\n*************************\n"
check_set.each do
	|element|
	index = Digest::murmur_hash2(element.to_s,seed)%10
	if bloom_filter[index]==true then
		puts "#{element} might be present in set"
	else
		puts "#{element} is not present in set"
	end
end
