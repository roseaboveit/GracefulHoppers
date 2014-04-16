require 'spec_helper'

describe Unit do
  describe "validations" do
    it "has a valid factory" do
      expect(build(:unit)).to be_valid
    end

    it "has a description" do
      expect(build(:unit, description: nil)).to be_invalid
    end

    it "has a total point value as an integer" do
      expect(build(:unit, total_points: nil)).to be_invalid
      expect(build(:unit, total_points: "fish")).to be_invalid
    end

    it "has a published status as a boolean" do
      expect(build(:unit, published: nil)).to be_invalid
    end
  end

  describe "associations" do

    let(:unit) { create(:unit) }

    it "responds to lessons" do
      create(:unit)
      expect(unit).to respond_to(:lessons)
    end
  end
end
