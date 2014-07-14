require 'test_helper'

class HelpfulTest < ActiveSupport::TestCase
  before do
    DatabaseCleaner.start
    @u = User.create( email: "abc@gmail.com")
    @h1 = Helpful.create( user: @u, url: "http://www.salas.com/foobar", value: true )
    @h2 = Helpful.create(value: "false", user: @u)
  end

  after do
    DatabaseCleaner.clean
  end

  describe Helpful do
    it "can detect existance" do
      Helpful.exists?(an_email: "abc@gmail.com", 
                      a_url: "http://www.salas.com/foobar").must_equal true
    end

    it "correctly returns value" do
      helprec = Helpful.defaulted_find(an_email: "abc@gmail.com", 
                  a_url: "http://www.salas.com/foobar")
      helprec[0].value.must_equal true
    end
  end
end
