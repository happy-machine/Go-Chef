require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name:'test', email:'tes@aol.com', password: 'blahblah')
    @review = @user.reviews.create!(comment:'ho',user_id:1)
  end

  describe 'validations' do
    it { should validate_presence_of :comment }
  end
  describe 'relations' do
  end

  describe 'default values' do
    it 'should set always return a default rating value' do
      expect(@review.rating).to eq 1 
    end
  end

end