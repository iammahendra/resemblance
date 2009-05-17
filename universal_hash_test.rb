#!/usr/bin/ruby
require 'universal_hash'

uh = UniversalHash.build #_with [3457568,53457568,353467588]

require 'shingling.rb'
freqs = [] # [ {'0' => 13, '1'=>12}, etc ]
'i just found out the other day that The presets are an australian band'.shingles.each { |sh|
	hash = sprintf "%064b\n", uh.hash(sh)
	puts "hash #{hash}"
	hash.chomp.chars.each_with_index do |bit, idx|
		bit = bit.to_i
		freqs[idx] ||= {}
		freqs[idx][bit] ||= 0
		freqs[idx][bit] += 1
	end
}
class Array
	def sum 
		inject(0){|a,n| n+a}
	end
end
spreads = []
freqs.each_with_index do |f,i|
	unset, set = f[0], f[1]
	unset ||= 0
	set ||= 0
	spread = unset.to_f/(unset+set)
	spreads << spread
	puts "#{i} 0=>#{unset} 1=>#{set} spread=#{spread}"
end
puts "average spread #{spreads.sum.to_f / spreads.size}"
puts "mean spread #{spreads.sort[spreads.size/2]}"
