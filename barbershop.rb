require 'sinatra'

get '/' do
   	erb :index
end

# Asking name, phone, date
post '/' do
	@user_name=params[:user_name]
	@phone=params[:phone]
	@date_time=params[:date_time]
	
	@title='Thank you!'
	@message="Dear #{@user_name}, we'll be waiting you at #{@date_time}"
       
#write information into user.txt 
	f= File.open './public/users.txt', 'a'
	f.write "User: #{@user_name}, Phone: #{@phone}, Date and time: #{@date_time}\n" 
	f.close

	erb :message
end

# Add zone /admin where we can see list of users from users.txt (as admin) 
# sinatra text file sso
get '/admin' do
	erb :admin
end

post '/admin' do
	@login = params[:login]
	@password = params[:password]

	# checking login and password, if true you enter else not
	if @login == 'admin' && @password == 'oleg'
  	@file = File.open("./public/users.txt","r")
  	erb :watch_result
	  # @file.close - должно быть, но тогда не работает. указал в erb
	else
		@report = '<p>Access is denied! Wrong login or password.</p>'
		erb :admin
	end
end
