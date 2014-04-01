require 'spec_helper'

describe User do
  describe "validations" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end

    it "has a name" do
      expect(build(:user, name: nil)).to be_invalid
    end

    it "has a username" do
      expect(build(:user, username: nil)).to be_invalid
    end

    it "has a valid twitter uid" do
      expect(build(:user, twitter_uid: nil)).to be_invalid
    end

    it "has a valid email address" do
      expect(build(:user, email: nil)).to be_invalid
    end

    it "has a unit value" do
      expect(build(:user, unit: nil)).to be_invalid
      expect(build(:user, unit: "a")).to be_invalid
    end
  end
end
