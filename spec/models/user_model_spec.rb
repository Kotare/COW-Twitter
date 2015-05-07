require_relative '../spec_helper'

describe "User" do
  let(:sally) {User.create(username: 'sally',
                          email: 'sally@example.com',
                          password: 'password1')}
  let(:obama) {User.create(username: 'obama',
                          email: 'obama@example.com',
                          password: 'password1')}

  describe "User follower/followee relationships" do
    before do
      obama.followers << sally
    end

    it "User has correct followers in connections table" do
      expect(obama.followers).to include(sally)
    end

    it "User has correct followees in connections table" do
      puts "Sally"
      pp sally
      pp sally.follower_connections
      pp sally.followee_connections
      pp sally.followees
      # puts "Obama"
      # pp obama
      # pp obama.followee_connections
      expect(sally.followees).to include(obama)

    end

  end

end
