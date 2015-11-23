class StaticPagesController < ApplicationController

	def show

	  	name = params[:name]
	  	phone = params[:phone]

	  	fullname = name.split(' ')
	  	firstname = fullname[0]

	  	validphone = false
	  	arraylength = fullname.length

	  	# render text: "Full name: #{fullname} // First name: #{firstname} // array lenght = #{arraylength}"

	  	validphone = valid?(phone)

	  	if validphone == true
		  	# Instantiate a Twilio client
		    client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
		      
		    # Create and send an SMS message
		    client.account.sms.messages.create(
		    	from: '+19192996004',
		    	to: phone,
		    	body: "Thanks #{firstname}. Please find my resume here: https://goo.gl/dQuEVV."
		    )
		else
			render text: "Please Enter A Valid Phone Number"
		end

  	end

	def valid?(phone_number)
		lookup_client = Twilio::REST::LookupsClient.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
		begin
			response = lookup_client.phone_numbers.get(phone_number)
			response.phone_number #if invalid, throws an exception. If valid, no problems.
		    return true
		rescue => e
		    return false
  		end
	end

end

