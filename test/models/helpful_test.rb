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
      Helpful.exists?(email: "abc@gmail.com", 
                      url: "http://www.salas.com/foobar").must_equal true
    end

    it "correctly returns value" do
      helprec = Helpful.defaulted_find(email: "abc@gmail.com", 
                  url: "http://www.salas.com/foobar")
      helprec[0].value.must_equal true
    end

    it "correctly adds a new user" do
      assert_difference 'User.count' do
        Helpful.voted?(ip: "1.1.1.1", url: "http://www.salas.com/bar")
      end
    end

    it "correctly does not add a new user" do
      User.create(email:"pitosalas@gmail.com")
      assert_difference 'User.count', 0 do
        Helpful.voted?(email:"pitosalas@gmail.com", url: "http://www.salas.com/bar")
      end
    end

    it "should record a new vote" do
      assert_difference 'Helpful.count' do
        Helpful.vote(value: true, email:"pitosalas@gmail.com", url: "http://www.salas.com/bar")
      end
    end
  end
end
