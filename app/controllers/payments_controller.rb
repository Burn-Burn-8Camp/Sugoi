class PaymentsController < ApplicationController
	def payment
		render html: params
	end
end
