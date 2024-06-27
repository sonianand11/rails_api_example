require 'rails_helper'

RSpec.describe User, type: :model do
  subject { 
    described_class.new(
      email: "test@example.com", 
      username: "testuser", 
      password: "password123", 
      password_confirmation: "password123"
    )
  }

  context "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a duplicate email" do
      described_class.create!(email: "test@example.com", username: "anotheruser", password: "password123", password_confirmation: "password123")
      expect(subject).to_not be_valid
    end

    it "is not valid with an invalid email format" do
      subject.email = "invalidemail"
      expect(subject).to_not be_valid
    end

    it "is not valid without a username" do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a duplicate username" do
      described_class.create!(email: "another@example.com", username: "testuser", password: "password123", password_confirmation: "password123")
      expect(subject).to_not be_valid
    end

    it "is not valid with a password less than 6 characters" do
      subject.password = "short"
      subject.password_confirmation = "short"
      expect(subject).to_not be_valid
    end

    it "is valid with a password of at least 6 characters" do
      subject.password = "secure"
      subject.password_confirmation = "secure"
      expect(subject).to be_valid
    end

    it "is valid without a password if not a new record" do
      subject.save
      subject.password = nil
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a password if it's nil for a new record" do
      subject.password = nil
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end
  end
end

