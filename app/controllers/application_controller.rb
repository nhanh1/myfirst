class ApplicationController < ActionController::Base
	respond_to :html, :json
	protected

	def initialize_omniauth_state
		session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
	end
end
