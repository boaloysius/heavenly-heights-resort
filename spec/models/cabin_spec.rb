require 'rails_helper'

RSpec.describe Cabin, type: :model do
  subject {
    described_class.new(
      maxCapacity: 4,
      regularPrice: 200,
      discount: 50,
      name: '001',
      imageFile: fixture_file_upload('spec/fixtures/files/sample_cabin_image.jpg', 'image/jpeg'),
      description: 'A lovely cabin'
    )
  }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a maxCapacity' do
      subject.maxCapacity = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a regularPrice' do
      subject.regularPrice = nil
      expect(subject).to_not be_valid
    end

    it 'is valid without a discount' do
      subject.discount = nil
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a non-unique name' do
      described_class.create(
        maxCapacity: 4,
        regularPrice: 200,
        discount: 50,
        name: '001',
        imageFile: fixture_file_upload('spec/fixtures/files/sample_cabin_image.jpg', 'image/jpeg'),
        description: 'A lovely cabin'
      )
      expect(subject).to_not be_valid
    end

    # it 'is not valid without an image' do
    #   subject.imageFile = nil
    #   expect(subject).to_not be_valid
    # end

    it 'is not valid without a description' do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if discount is greater than or equal to regularPrice' do
      subject.discount = 200
      expect(subject).to_not be_valid

      subject.discount = 250
      expect(subject).to_not be_valid
    end
  end
end
