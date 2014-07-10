module Api
  class HelpfulController < ApplicationController
    skip_before_action :verify_authenticity_token

    #
    # POST helpful?value=yes&guid=12312312312&email=pitosalas@gmail.com
    #
    # guid = a guid to identify this user
    # email = an email address to identify user
    # value = yes/no to indicate whether the page is helpful
    def submit
      new_params = Hash[ip: request.headers["REMOTE-ADDR"]]
      new_params = new_params.merge(params.permit(:url, :email, :value, :guid))
      render json: new_params
    end

    #
    # GET helpful?guid=12312312312&email=pitosalas@gmail.com
    #
    # guid = a guid to identify this user
    # email = an email address to identify user
    # value = yes/no to indicate whether the page is helpful
    def get
      new_params = Hash[ip: request.headers["REMOTE-ADDR"]]
      new_params = new_params.merge(params.permit(:url, :email, :guid))
      render json: new_params
    end

    private

  end
end