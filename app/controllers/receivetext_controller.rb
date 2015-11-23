class ReceiveTextController < ApplicationController
	def respond
		from_number = params["From"]

		# Instantiate a Twilio client
		client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
		      
		# Create and send an SMS message
		client.account.sms.messages.create(
	    	from: ENV['TWILIO_PHONE_NUMBER'],
	    	to: from_number,
	    	body: "This is an automated response"
    	)
	end
end