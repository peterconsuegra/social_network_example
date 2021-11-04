class MainController < ApplicationController
    
    def index
        redirect_to sign_in_path if Current.user.nil?
    end

end