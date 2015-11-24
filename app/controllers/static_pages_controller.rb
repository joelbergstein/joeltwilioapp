class StaticPagesController < ApplicationController
skip_before_filter  :verify_authenticity_token

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
		    client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
		      
		    # Create and send an SMS message
		    client.account.sms.messages.create({
		    	:from => ENV['TWILIO_PHONE_NUMBER'],
		    	:to => phone,
		    	:body => "Thanks #{firstname}. Please find my resume here: https://goo.gl/dQuEVV. Text MORE for additional information."
		    })
		else
			render text: "Please Enter A Valid Phone Number"
		end

  	end

  	def respond
		from_number = params["From"]
		message_body = params["Body"]

		#message_response = ""

		case message_body.downcase
		when "more"
			message_response = "Text GIT to see the source for this web app. Text WEBSITE to see more of my work."
		when "git"
			message_response = "See the code behind this app, visit https://github.com/joelbergstein/joeltwilioapp"
		when "website"
			message_response = "See my personal website at http://www.joelbergstein.com"
		else
			message_response = "No options for \"#{message_body}\". Please text MORE for additional information."
		end


		# Instantiate a Twilio client
		@client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
		      
		# Create and send an SMS message
		@client.account.sms.messages.create({
	    	:from => ENV['TWILIO_PHONE_NUMBER'],
	    	:to => from_number,
	    	:body => message_response
		})

		render nothing: true
	end

	def valid?(phone_number)
		lookup_client = Twilio::REST::LookupsClient.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
		begin
			response = lookup_client.phone_numbers.get(phone_number)
			response.phone_number #if invalid, throws an exception. If valid, no problems.
		    return true
		rescue => e
		    return false
  		end
	end

end

