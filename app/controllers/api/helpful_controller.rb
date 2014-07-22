module Api
  class HelpfulController < ApplicationController
    skip_before_action :verify_authenticity_token

    #
    # GET helpful?value=yes&guid=12312312312&email=pitosalas@gmail.com
    #
    # url = the page in question
    # guid = a guid to identify this user
    # email = an email address to identify user
    # value = yes/no to indicate whether the page is helpful
    def vote
      stats = Helpful.vote_and_get_stats(
        value: value(params), url: url(params), 
        ip: ip(request), guid: guid(params), email: email(params))
      render json: stats, callback: callback(params)
    end

    #
    # GET helpful?guid=12312312312&email=pitosalas@gmail.com
    #
    # url = the page in question
    # guid = a guid to identify this user
    # email = an email address to identify user
    # value = yes/no to indicate whether the page is helpful
    def voted
      resp = Helpful.voted?(
        url: url(params), 
        ip: ip(request), guid: guid(params), email: email(params))
      render json: resp, callback: callback(params)
    end

    #
    # GET helpful/visiting?url="xxx"
    #
    # url = the page in question
    # Returns a hash: {true: 12, false: 2} to reflect how many yes and no votes
    #   this page has seen so far.
    def visiting
      stats = resp = Helpful.get_stats(url(params))
      render json: stats, callback: callback(params)
    end      

    private

    def clean_params(params, valid_keys)
      params.keep_if { |key, value| valid_keys.include? key }
    end

    def callback params
      params.fetch('callback')
    end

    def ip request
      request.remote_ip
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

    def guid params
      params['guid']
    end

  end
end