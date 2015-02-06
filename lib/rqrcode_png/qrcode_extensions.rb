module RQRCodePNG
  module QRCodeExtensions 
    # This method returns a 33x33 .png of the code
    def to_img(opts = {})
      bg_color = opts[:bg_color] || ChunkyPNG::Color::WHITE
      opts.delete(:bg_color)
      return Image.new(self, opts).render(bg_color)
    end
  end
end

