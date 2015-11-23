class StaticPagesController < ApplicationController

  def show

  	phone = params[:phone]


  	# Instantiate a Twilio client
    client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
      
    # Create and send an SMS message
    client.account.sms.messages.create(
    	from: '+19192996004',
    	to: phone,
    	body: "Thanks. Please find my resume here: https://goo.gl/dQuEVV."
    )

  end

end
