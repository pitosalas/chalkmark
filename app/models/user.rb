class User < ActiveRecord::Base

  def self.multi_find_or_create(email: nil, guid: nil, ip: nil)
    if !email.nil?
      u = User.where(email: email)
    elsif !ip.nil?
      u = User.where(ip: ip)
    elsif !guid.nil?
      u = User.where(guid: guid)
    else
      u = User.create(email: email, guid:guid, ip: ip)
    end
    u
  end

end
