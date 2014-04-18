require 'spec_helper'

describe Segment do
  describe "Validations" do
    it "should have a valid factory" do
      expect(build(:segment)).to be_valid
    end

    it "should have a valid content type" do
      expect(build(:segment, content_type: nil)).to be_invalid
      expect(build(:segment, content_type: "fish")).to be_invalid
    end

    it "should have content" do
      expect(build(:segment, content: nil)).to be_invalid
    end

    it "should have a place value" do
      expect(build(:segment, place_value: nil)).to be_invalid
    end
  end
end
