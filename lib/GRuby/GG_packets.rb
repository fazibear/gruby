module GG
  class PACKET
    def initialize
      puts "++ #{self} created" if $DEBUG
    end

    def destroy
      puts "++ #{self} destroyed" if $DEBUG
      nil
    end

    def header=(data)
      unpacked = data.unpack 'II'
      @type, @length = unpacked
      puts "++ #{self} recived header ... type:#{@type} length:#{@length}" if $DEBUG
    end

    def header_length
      8
    end

    def type
      @type
    end

    def length
      @length
    end

    def type=(type)
      begin
        self.extend	type
        puts "++ #{self} extend to #{type}" if $DEBUG
        fields @data if @data
      rescue => e
        raise "class extend ... #{e}"
      end
    end

    def data=(data)
      @data = data
      puts "++ #{self} recived data" if $DEBUG
    end

    def pack(pattern)
      begin
        puts "++ #{self} data packed" if $DEBUG
        packet.pack pattern
      rescue => e
        raise "packet pack ... #{e}"
      end
    end
  end

  # RECV PACKETS #

  module PACKET_WELCOME
    attr_reader :seed

    def type
      WELCOME
    end

    def fields(data)
      unpacked = data.unpack 'I'
      @seed = unpacked[0]
    end
  end

  module PACKET_RECV_MSG
    attr_reader :sender		# numer nadawcy
    attr_reader :seq		  # numer sekwencyjny
    attr_reader :time			# czas nadania
    attr_reader :class		# klasa wiadomości
    attr_reader :message	# treść wiadomości

    def type
      RECV_MSG
    end

    def fields(data)
      unpacked = data.unpack 'IIIIZ*'
      @sender,
      @seq,
      @time,
      @class,
      @message = unpacked
    end

  end

  module PACKET_SEND_MSG_ACK
    attr_reader :status	   # stan wiadomości */
    attr_reader :recipient # numer odbiorcy */
    attr_reader :seq 	     # numer sekwencyjny */

    def type
      SEND_MSG_ACK
    end

    def fields(data)
      unpacked = data.unpack 'III'
      @status,
      @recipient,
      @seq = unpacked
    end
  end

  # SEND PACKECTS #

  module PACKET_LOGIN60
    attr_writer :uin           # mój numerek
    attr_writer :hash          # hash hasła */
    attr_writer :status        # status na dzień dobry */
    attr_writer :version       # moja wersja klienta */
    attr_writer :unknown1      # 0x00 */
    attr_writer :local_ip      # mój adres ip */
    attr_writer :local_port    # port, na którym słucham */
    attr_writer :external_ip   # zewnętrzny adres ip */
    attr_writer :external_port # zewnętrzny port */
    attr_writer :image_size    # maksymalny rozmiar grafiki w KB */
    attr_writer :unknown2      # 0xbe */
    attr_writer :description   # opis, nie musi wystąpić */
    attr_writer :time          # czas, nie musi wystąpić */

    def type
      LOGIN60
    end

    def packet
      [
        type,
        length,
        @uin           ? @uin              : 0,
        @hash          ? @hash             : 0,
        @status        ? @status           : 0,
        @version       ? @version          : 0x22,
        @unknown1      ? @unknown1         : 0,
        @local_ip      ? @local_ip         : 0,
        @local_port    ? @local_port       : 0,
        @external_ip   ? @external_ip      : 0,
        @external_port ? @external_port    : 0,
        @image_size    ? @image_size       : 0,
        @unknown2      ? @unknown2         : 0xBE,
        @description   ? "#{@description}" : "\0",
        @time          ? @time             : 0
      ]
    end

    def length
      4+4+4+4+1+4+2+4+2+1+1+(@description ? @description.length : 1)+4
    end

    def packed
      pack 'II IIIIcIsIsccA*I'
    end

  end

  module PACKET_NEW_STATUS
    attr_writer :status				# na jaki zmienić? */
    attr_writer :description	# opis, nie musi wystąpić */
    attr_writer :time					# czas, nie musi wystąpić */

    def type
      NEW_STATUS
    end

    def packet
      [
        type,
        length,
        @status      ? @status           : 0,
        @description ? "#{@description}" : "\0",
        @time        ? @time             : 0
      ]
    end

    def length
      4+(@description ? @description.length : 1)+4
    end

    def packed
      pack 'II IA*I'
    end
  end

  module PACKET_LIST_EMPTY
    def type
      LIST_EMPTY
    end
    def packet
      [
        type,
        length
      ]
    end

    def length
      0
    end

    def packed
      pack 'II'
    end
  end

  module PACKET_SEND_MSG
    attr_writer :recipient		# numer odbiorcy */
    attr_writer :seq		      # numer sekwencyjny */
    attr_writer :class 				# klasa wiadomości */
    attr_writer :message		  # treść */

    def type
      SEND_MSG
    end

    def packet
      [
        type,
        length,
        @recipient ? @recipient     : 0,
        @seq       ? @seq           : 0,
        @class     ? @class         : 0x0008,
        @message   ? "#{@message}"  : "\0"
      ]
    end

    def length
      4+4+4+@message.length
    end

    def packed
      pack 'II IIIA*'
    end
  end
end
