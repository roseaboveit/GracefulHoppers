require 'spec_helper'

describe Lesson do
  let (:unit) { create(:unit) }

  describe 'validations' do
    it "has a valid factory" do
      expect(build(:lesson)).to be_valid
    end

    it "has a description" do
      expect(build(:lesson, description: nil)).to be_invalid
    end

    it "has a point value" do
      expect(build(:lesson, points: nil)).to be_invalid
      expect(build(:lesson, points: "fish")).to be_invalid
    end

    it "is associated with a valid path" do
      expect(build(:lesson, path: "reflection")).to be_valid
      expect(build(:lesson, path: "fish")).to be_invalid
    end

    it "is associated with a unit" do
      expect(build(:lesson, unit_id: nil)).to be_invalid
    end
  end
end
