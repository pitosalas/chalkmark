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
      new_params = Hash[ip: request.headers["REMOTE-ADDR"]]
      new_params = new_params.merge(params)
      value = params.fetch(:value) == "true"
      new_params.symbolize_keys!
      new_params = clean_params(new_params, [:url, :guid, :ip, :email])
      stats = Helpful.vote_and_get_stats(value, new_params)
      render json: helpful
    end

    #
    # GET helpful?guid=12312312312&email=pitosalas@gmail.com
    #
    # url = the page in question
    # guid = a guid to identify this user
    # email = an email address to identify user
    # value = yes/no to indicate whether the page is helpful
    def get
      new_params = Hash[ip: request.headers["REMOTE-ADDR"]]
      new_params = new_params.merge(params)
      new_params.symbolize_keys!
      new_params = clean_params(new_params, [:url, :guid, :ip, :email])
      helpful = Helpful.voted?(new_params)
      render json: helpful
    end

    private

    def clean_params(params, valid_keys)
      params.keep_if { |key, value| valid_keys.include? key }
    end

  end
end