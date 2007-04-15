module GG

  #
  # Return new GG session
  #
  def self.new_session( params )
    Session.new( params )
  end 

  class Session

    attr_reader :connected

    def initialize( params )
      @uin = params[:uin]
      @password = params[:password]
      @revice_msg_callback = nil
      @message_seq = 0
      @connected = true
      @logged = false
      @socket = nil
      @wait4login = true 
      @wait4login = params[:async] unless params[:async].nil?
      socket_thread = Thread.new do
        begin
          params = GG::connection_params
          @socket = TCPSocket.new( params['host'] , params['port'] )
          while @connected do
            begin
              r_packet = PACKET.new
              puts ":: Wait for data ..." if $DEBUG
              r_packet.header = @socket.read r_packet.header_length
              r_packet.data   = @socket.read r_packet.length
            rescue => e
              @logged = false
              @connected = false
            end
            case r_packet.type
            when WELCOME
              r_packet.type   = PACKET_WELCOME
              s_packet        = PACKET.new
              s_packet.type   = PACKET_LOGIN60
              s_packet.uin    = @uin.to_i
              s_packet.hash   = GG::login_hash( @password, r_packet.seed )

              @socket.write s_packet.packed
              puts "++ #{s_packet} send" if $DEBUG
              s_packet = s_packet.destroy
            when LOGIN_OK
              @logged = true
              @wait4login = false
            when RECV_MSG
              r_packet.type   = PACKET_RECV_MSG

              @recive_msg_callback.call r_packet
            when SEND_MSG_ACK
              r_packet.type =   PACKET_SEND_MSG_ACK
            else
              puts "?? Unknown packet" if $DEBUG 
            end
            r_packet = r_packet.destroy
          end
          puts ":: Disconected" if $DEBUG
        rescue => e
          puts "!! Exception: #{e}" if $DEBUG
          puts "Something went wrong :)" unless $DEBUG
          exit 0
        end
      end
      while @wait4login do
        sleep 1
      end
    end


    #
    # Recive message callback
    #
    def on_recive_message( &block )
      @recive_msg_callback = block;
    end

    #
    # Send message
    #   :uin => GG reciver number 
    #   :message => message text
    #
    def send_message( params )
      if @logged
        s_packet           = PACKET.new
        s_packet.type      = PACKET_SEND_MSG
        s_packet.recipient = params[:uin]
        s_packet.message   = params[:message]

        @socket.write s_packet.packed
        puts "++ #{s_packet} send" if $DEBUG
        s_packet = s_packet.destroy
      end
    end
    
    #
    # Set new status.
    #   :status => new status, see constans.
    #   :description => new description
    #
    def set_status( params )
      if @logged
        s_packet = PACKET.new
        s_packet.type = PACKET_NEW_STATUS
        s_packet.status = params[:status]
        s_packet.description = params[:description]

        @socket.write s_packet.packed
        puts "++ #{s_packet} send" if $DEBUG
        s_packet = s_packet.destroy
      end
    end

  end
end

