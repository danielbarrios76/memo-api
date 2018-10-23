require 'rails_helper'

RSpec.describe Memo, type: :model do
  describe 'validations' do
    it 'requires title to be present' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'requires body to be present' do
      subject.body = nil
      expect(subject).not_to be_valid
    end

    it 'requires complied to be present' do
      subject.complied = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'factory' do
    let(:memo) { create(:memo) }

    it 'creates a valid memo instance' do
      expect(memo).to be_valid
      expect(memo).to be_persisted
    end
  end
end
