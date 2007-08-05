module GG
  
  #
  # Return calculated password hash.
  #
  def self.login_hash ( password, seed )
    x = 0;
    y = seed;
    z = 0;

    password.each_byte do |char|
      x = ( x & 0xffffff00 ) | char.to_i
      y ^= x;
      y &= 0xffffffff
      y += x;
      y &= 0xffffffff
      x <<= 8;
      x &= 0xffffffff
      y ^= x;
      y &= 0xffffffff
      x <<= 8;
      x &= 0xffffffff
      y -= x;
      y &= 0xffffffff
      x <<= 8;
      x &= 0xffffffff
      y ^= x;
      y &= 0xffffffff
      z = y & 0x1f;
      z &= 0xffffffff
      y = (y << z) | (y >> (32 - z))
      y &= 0xffffffff
    end
    return y;
  end

  # 
  # Return connection params returned from gg server.
  #
  def self.connection_params
    require 'open-uri'
	gg_connection = open("http://appmsg.gadu-gadu.pl/appsvc/appmsg4.asp?fmnumber=").readlines[0].split(/\s/)[2].split(':')
	gg_connection_param = { 
    	'host' => gg_connection[0],
    	'port' => gg_connection[1]
    }
    puts ":: Connection params ... host:#{gg_connection_param['host']} port:#{gg_connection_param['port']}" if $DEBUG
    return gg_connection_param
  end
end
