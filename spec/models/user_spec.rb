require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create!(name:'test', email:'test@aol.com', password: 'blahblah')
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
  end
  
  describe 'relations' do
  end

  describe 'default values' do
    it 'should set the values to default' do
      expect(@user.location_lat).to eq -0.09039    
    end
  end

  describe "#av_rating" do
    before do
      @user.reviews.create!(rating:5,comment:'test')
      @user.reviews.create!(rating:3,comment:'test')
    end

    it 'should return an average of all ratings for this user' do
      @user.reviews.create!(rating:1,comment:'test')
      expect(@user.av_rating).to eq 3
    end
    it 'should return the closest whole number when floating point result (rounding down)' do
      @user.reviews.create!(rating:2,comment:'test')
      expect(@user.av_rating).to eq 3
    end 
    it 'should return the closest whole number when floating point result (rounding up)' do
      @user.reviews.create!(rating:3,comment:'test')
      expect(@user.av_rating).to eq 4
    end
    it 'should return 1 when there are no ratings' do
      @user = User.create!(name:'test', email:'test2@aol.com', password: 'blahblah')
      expect(@user.av_rating).to eq 1
  end
  end

  describe '#search'do
  it 'should return a result like the search term' do
    @user2 = User.search('tes')
    expect(@user2[0].name).to eq 'test'
  end

  it 'should return all if there is no search term' do
    @user2 = User.search(nil)
    expect(@user2).to eq User.all
  end
  end
end