class Helpful < ActiveRecord::Base
  belongs_to :user

  def self.exists?(*all_args)
    res = self.defaulted_find(*all_args)
    res.length > 0
  end

  # def self.defaulted_find(an_email: nil, an_ipaddr: nil, a_guid: nil, a_url: nil)
  #   joined = Helpful.joins(:user)
  #   if !an_email.nil?
  #     joined.where(users: {email: an_email}, url: a_url)
  #   elsif !a_guid.nil?
  #     where(users: {guid: a_guid}, url: a_url)
  #   elsif !an_ipaddr.nil?
  #     where(users: {ip: an_ipaddr}, url: a_url)
  #   else
  #     []
  #   end
  # end

  def self.defaulted_find(*args)
    args = args[0]  # just unpact the way args are passed in a *args scenario
    url = args.delete(:url) or raise ArgumentError, ":url must be provided"
    if args.present?
      Helpful.joins(:user).where(users: args, url: url)
    else
      []
    end
  end
end
