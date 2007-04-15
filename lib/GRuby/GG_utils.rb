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
    require 'socket'
    http = TCPSocket.new('appmsg.gadu-gadu.pl', '80')
    http.puts "GET /appsvc/appmsg4.asp?fmnumber=&version=&fmt=&lastmsg= HTTP/1.0\r\n"
    gg_connection = http.read.split("\r\n")[2].split(' ')[2].split(':')
    gg_connection_param = { 
    'host' => gg_connection[0],
    'port' => gg_connection[1]
    }
    http.close
    puts ":: Connection params ... host:#{gg_connection_param['host']} port:#{gg_connection_param['port']}" if $DEBUG
    return gg_connection_param
  end
end
