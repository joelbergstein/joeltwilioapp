class StaticPagesController < ApplicationController

  def show

  	name = params[:name]
  	phone = params[:phone]
  	timestring = params[:localtime]

  	# Instantiate a Twilio client
    client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
      
    # Create and send an SMS message
    client.account.sms.messages.create(
    	from: '+19192996004',
    	to: phone,
    	body: "Thanks #{name}. Please find my resume here: https://goo.gl/dQuEVV. Sent at #{timestring}"
    )

  end

end
