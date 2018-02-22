
APP_KEY = "e1zq5n1ls5k9gbw"
APP_SECRET = "waeauk51gcap34b"

class DropboxController < ApplicationController

    def main

    	flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
    	authorize_url = flow.start()

    	puts ' 1. Vaya a: ' + authorize_url 
		puts ' 2. Haga clic en "Permitir" (puede que tenga que iniciar sesión primero) ' 
		puts ' 3. Copie el código de autorización ' 
		print' Introduzca el código de autorización aquí: ' 
		code = gets.strip

		access_token, user_id = flow.finish(code)

    end
end

