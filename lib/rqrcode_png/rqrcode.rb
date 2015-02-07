module RQRCode #:nodoc:

  class QRCode 
    SIZE_RESTRICTIONS = [0, 7, 14, 24, 34, 44, 58, 64, 84, 98, 119]
    # Expects a string to be parsed in, other args are optional
    #
    #   # string - the string you wish to encode
    #   # size   - the size of the qrcode (default 4)
    #   # level  - the error correction level, can be:
    #      * Level :l 7%  of code can be restored
    #      * Level :m 15% of code can be restored
    #      * Level :q 25% of code can be restored
    #      * Level :h 30% of code can be restored (default :h)
    #
    #   qr = RQRCode::QRCode.new('hello world', :size => 1, :level => :m )
    #

    def initialize( string, *args  )
      if !string.is_a? String
        raise QRCodeArgumentError, "The passed data is #{string.class}, not String"
      end

      options               = args.extract_options!
      level                 = (options[:level] || :h).to_sym
      size                  = options[:size] || compute_size(string)

      if !QRERRORCORRECTLEVEL.has_key?(level)
        raise QRCodeArgumentError, "Unknown error correction level `#{level.inspect}`"
      end

      @data                 = string
      @error_correct_level  = QRERRORCORRECTLEVEL[level]
      @version              = size
      @module_count         = @version * 4 + QRPOSITIONPATTERNLENGTH
      @modules              = Array.new( @module_count  )
      @data_list            = QR8bitByte.new( @data  )
      @data_cache           = nil

      self.make
    end

    private
    def compute_size(str)
      slen = str.size
      ii = 0
      while ii < SIZE_RESTRICTIONS.length do
        if slen < SIZE_RESTRICTIONS[ii]
          break
        end
        ii+=1
      end
      if ii > 10
        raise "Your string is too big for this encoder.  It should be less than #{SIZE_RESTRICTIONS.last} characters"
      end
      return ii
    end

  end

end
