class Helpful < ActiveRecord::Base
  belongs_to :user

  def self.voted?(*args)
    args = args[0]
    url = args.delete(:url) or raise ArgumentError, ":url must be provided"
    usr = User.multi_find_or_create(args)
    !Helpful.where(user: usr, url: url).take.nil?
  end

  def self.vote(value, *args)
    args = args[0]
    url = self.extract_url(args)
    usr = User.multi_find_or_create(args)
    helpful = Helpful.find_or_create_by(user: usr, url: url, value: value )
  end

  # Sets the vote, and returns a count of yes and no helpful votes so far on this url
  def self.vote_and_get_stats(value, *args)
    helpful = self.vote(value, *args)
    [1,1]
  end

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

  def self.extract_url(args)
    p = args.delete(:url) or raise ArgumentError, ":url must be provided"
  end


end
