module RQRCodePNG
  module QRCodeExtensions 
    # This method returns a 33x33 .png of the code
    def to_img(opts = {})
      img_opts = {}
      img_opts[:bg_color] = opts.delete(:bg_color)
      img_opts[:fg_color] = opts.delete(:fg_color)
      return Image.new(self, opts).render(img_opts)
    end
  end
end

