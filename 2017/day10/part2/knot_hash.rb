def knot_hash(string, lengths, position=0, skip=0)
  n = string.length # circular
  
  lengths.each do |length|
    # get elements
    t = (position...position+length).map { |i| string[i%n] }
    t.reverse! # reverse the sub-array
    
    # write back the reversed sub-array to the string
    t.each_with_index { |e,i| string[(position+i)%n] = e }
    
    # update position
    position = (position+length+skip) % n
    
    # increment 
    skip += 1
  end
    
  [string,position,skip]
end

def hash(input)
  string = (0..255).to_a
  position = skip = 0
  lengths = input.chars.map(&:ord) + [17,31,73,47,23] # remove spaces
  product = nil
  
  # run rounds
  64.times do
    product,position,skip = knot_hash(string, lengths, position, skip)
  end
  
  # 16 times * 16 bytes
  nums = product.each_slice(16).map { |x| x.reduce(:^) }
  nums.map { |x| x.to_s(16).rjust(2,'0') }.join # to_hex
end
