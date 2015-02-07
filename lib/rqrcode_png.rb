require 'chunky_png'
require 'rqrcode'

require 'rqrcode_png/version'
require 'rqrcode_png/sequence'
require 'rqrcode_png/image'
require 'rqrcode_png/qrcode_extensions'
require 'rqrcode_png/rqrcode'

RQRCode::QRCode.send :include, RQRCodePNG::QRCodeExtensions
