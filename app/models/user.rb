class User < ActiveRecord::Base

  def self.multi_find_or_create(email: nil, guid: nil, ip: nil)
    u = nil
    if !email.nil?
      u = User.where(email: email).take
    elsif !ip.nil?
      u = User.where(ip: ip).take
    elsif !guid.nil?
      u = User.where(guid: guid).take
    end
    if u.nil?
      u = User.create(email: email, guid:guid, ip: ip)
    end
    u
  end

end
