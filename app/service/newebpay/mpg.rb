module Newebpay
	class Mpg
		attr_accessor :info
		def initialize(params)
			@key = ENV["merchant_hash_key"]
			@iv = ENV["merchant_hash_iv"]
			@merchant_id = ENV["merchant_id"]
			@info = {}
			set_info(params)
		end

		# 把資料打包成要POST出去的格式
		def form_info
			{
				MerchantID: @merchant_id,
				TradeInfo: trade_info,
				TradeSha: trade_sha,
				Version: '1.6'
			}
		end

		
		private
		# 把必填資料填進去
		def set_info(order)
			info[:MerchantID] = @merchant_id
			info[:MerchantOrderNo] = order.serial
			info[:Amt] = order.total
			info[:ItemDesc] = '串接測試'
			info[:Email] = order.email
			info[:TimeStamp] = Time.now.to_i
			info[:RespondType] = 'JSON'
			info[:Version] = '1.6'
			info[:ReturnURL] = 'https://76ae-220-133-155-141.ngrok.io/orders/response'
			info[:NotifyURL] = 'https://76ae-220-133-155-141.ngrok.io/orders/response'
			info[:LoginType] = 0
			info[:CREDIT] = 1
			info[:VACC] = 1
		end

		def trade_info
			aes_encode(url_encoded_query_string)
		end

		# 第一道加密 藍新的規則
		def aes_encode(string)
			cipher = OpenSSL::Cipher::AES256.new(:CBC)
			cipher.encrypt
			cipher.key = @key
			cipher.iv = @iv
			cipher.padding = 0
			padding_data = add_padding(string)
			encrypted = cipher.update(padding_data) + cipher.final
			encrypted.unpack('H*').first
		end
		def add_padding(data, block_size = 32)
			pad = block_size - (data.length % block_size)
			data + (pad.chr * pad)
		end
		def url_encoded_query_string
			URI.encode_www_form(info)
		end

		def trade_sha
			sha256_encode(@key, @iv, trade_info)
		end

		# 第二道SHA加密
		def sha256_encode(key, iv, trade_info)
			encode_string = "HashKey=#{key}&#{trade_info}&HashIV=#{iv}"
			Digest::SHA256.hexdigest(encode_string).upcase
		end
	end
end