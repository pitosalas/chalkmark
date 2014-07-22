class Helpful < ActiveRecord::Base
  belongs_to :user

  def self.voted?(url: nil, ip: nil, email: nil, guid: nil)
    usr = User.multi_find_or_create(ip: ip, email: email, guid: guid)
    !Helpful.where(user: usr, url: url).take.nil?
  end

  def self.vote(value:, url:, ip: nil, email: nil, guid: nil)
    usr = User.multi_find_or_create(ip: ip, email: email, guid: guid)
    helpful = Helpful.find_or_create_by(user: usr, url: url, value: value )
  end

  # Sets the vote, and returns a count of yes and no helpful votes so far on this url
  def self.vote_and_get_stats(value:, url:, ip: nil, email: nil, guid: nil)
    self.vote(value: value, url: url, ip: ip, email: email, guid: guid)
    self.get_stats(url)
  end

  def self.exists?(url: nil, ip: nil, email: nil, guid: nil)
    res = self.defaulted_find(url: url, ip: ip, email: email, guid: guid)
    res.length > 0
  end

  def self.defaulted_find(url: nil, ip: nil, email: nil, guid: nil)
    u =  User.multi_find(guid: guid, email: email, ip: ip)
    Helpful.where(user: u, url: url)
  end

  def self.get_stats(url)
    result = Helpful.where(url: url).group(:value).count
    result[true] ||= 0
    result[false] ||= 0
    result
  end
end
