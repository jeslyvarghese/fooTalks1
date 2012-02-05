module Digest
  def self.murmur_hash2( string, seed )
    # seed _must_ be an integer, but I do try to enforce that.
    # m and r are mixing constants generated offline.
    # They are not really magic, they just happen to work well.

    raise "seed isn't an integer, and I can't convert it either." unless 
      seed.is_a?( Integer ) or seed.respond_to?( 'to_i' )

    seed = seed.to_i unless seed.is_a?( Integer )

    m = 0x5bd1e995
    r = 24
    len = string.length

    h = ( seed ^ len )

    while len >= 4
      string.scan( /..../ ) do |data|
        k = data[0]
        k |= data[1] << 8
        k |= data[2] << 16
        k |= data[3] << 24

        k = ( k * m ) % 0x100000000
        k ^= k >> r
        k = ( k * m ) % 0x100000000

        h = ( h * m ) % 0x100000000
        h ^= k

        len -= 4
      end
    end

    if len == 3 then
      h ^= string[-1] << 16
      h ^= string[-2] << 8
      h ^= string[-3]
    end
    if len == 2 then
      h ^= string[-1] << 8
      h ^= string[-2]
    end
    if len == 1 then
      h ^= string[-1]
    end

    h = ( h * m ) % 0x100000000
    h ^= h >> 13
    h = ( h * m ) % 0x100000000
    h ^= h >> 15

    return h
  end
end