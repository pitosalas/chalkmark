module Api
  class HelpfulController < ApplicationController
    skip_before_action :verify_authenticity_token

    #
    # POST helpful?value=yes&guid=12312312312&email=pitosalas@gmail.com
    #
    # url = the page in question
    # guid = a guid to identify this user
    # email = an email address to identify user
    # value = yes/no to indicate whether the page is helpful
    def submit
      new_params = clean_params(new_params, [:url, :guid, :ip, :email])
      stats = Helpful.vote_and_get_stats(
        value: value(params), url: url(url), 
        ip: ip(params), guid: guid(params), email: email(params))
      render json: stats, callback: callback(params)
    end

    #
    # GET helpful?guid=12312312312&email=pitosalas@gmail.com
    #
    # url = the page in question
    # guid = a guid to identify this user
    # email = an email address to identify user
    # value = yes/no to indicate whether the page is helpful
    def get
      resp = Helpful.voted?(
        url: url(url), 
        ip: ip(params), guid: guid(params), email: email(params))
      render json: resp, callback: callback(params)
    end

    private

    def clean_params(params, valid_keys)
      params.keep_if { |key, value| valid_keys.include? key }
    end

    def callback params
      params.fetch('callback')
    end

    def ip request
      request.headers["REMOTE-ADDR"]
    end

    def value params
      ["yes", "YES", "y", "true", "TRUE", "t"].include? params["value"]
    end

    def url params
      params.fetch('url')
    end

    def email params
      params['email']
    end



  end
end