class User < ActiveRecord::Base

  def self.multi_find_or_create(email: nil, guid: nil, ip: nil)
    user = self.multi_find(email: email, guid: guid, ip: ip)
    puts "self.multifind or create ip: #{ip}"
    if user.nil?
      user = User.create(email: email, guid:guid, ip: ip)
    end
    user
  end

  def self.multi_find(email: nil, guid: nil, ip: nil)
    puts "self.multifind ip: #{ip}"
    user = nil
    if !email.nil?
      user = User.where(email: email).take
    elsif !ip.nil?
      user = User.where(ip: ip).take
    elsif !guid.nil?
      user = User.where(guid: guid).take
    end
    user
  end

end
