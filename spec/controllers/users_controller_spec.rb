require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = User.create!(avatar: Rails.root.join("db/seed_images/download1.jpeg").open, email: 'bella@dogchow.com', max_party_size: 12, price_per_head: 150, is_a_chef:true, is_chef?: true, password: 'pass123', name: 'Bella Marusiak', location_lat: 51.5033640,location_lon: -0.1276250, bio: 'Not a fussy eater but will do many tricks for a tasty treat.\n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum')
  end

  let(:valid_user) {
    @ainsley = User.create!(avatar: Rails.root.join("db/seed_images/ainsley.jpg").open, email: 'ainsleyharriet@gmail.com',max_party_size: 20, price_per_head: 800, is_a_chef:true, is_chef?: true, password: 'pass123', name: 'Ainsley Harriet', location_lat: 51.8745476,location_lon: -1.5338750, bio: 'Presenter for many BBC cooking shows.\n Ainsley Harriott (born 28 February 1957) is an English chef, television presenter, and entertainer. He is known for his BBC cooking shows Cant Cook, Wont Cook and Ready Steady Cook. ')
  }

  let(:valid_user_2) {
  @gordon = User.create!(avatar: Rails.root.join("db/seed_images/gordon.jpg").open, email: 'gordonramsey@gmail.com', max_party_size: 10, price_per_head: 2000, is_a_chef:true, is_chef?: true, password: 'pass123', name: 'Gordon Ramsey', location_lat: 51.5033640,location_lon: -0.1276250, bio: 'Swears a lot and has numerous TV shows in both UK and America.\n Born 8 November 1966 is a British chef, restaurateur, and television personality. Born in Scotland, Ramsay grew up in Stratford-upon-Avon. His restaurants have been awarded 16 Michelin stars in total.[1][2] His signature restaurant, Restaurant Gordon Ramsay in Chelsea, London, has held three Michelin stars since 2001. First appearing on television in the UK in the late 1990s, by 2004 Ramsay had become one of the best known chefs in British popular culture, and, along with other chefs such as Jamie Oliver, Nigella Lawson, and Delia Smith, he has influenced viewers to become more culinarily adventurous.')
  }


  before do
    @user = :valid_user
    @user2 = :valid_user_2
    sign_in @user
  end

  let(:valid_attributes) {
    {id: valid_user.id, email: 'ainsleyharriet@gmail.com',max_party_size: 20, price_per_head: 800, location_lat: 51.8745476,location_lon: -1.5338750, bio: 'Presenter for many BBC cooking shows.\n Ainsley Harriott (born 28 February 1957) is an English chef, television presenter, and entertainer. He is known for his BBC cooking shows Cant Cook, Wont Cook and Ready Steady Cook. '}
  }

  let(:invalid_attributes) {
    {content: "", user:"", room:""}
  }
  
  describe "GET #index" do

    context "with valid params" do
      it "should show index" do
        get :index
        expect(response).to be_success
      end
    end
  end

  describe "GET #search" do

    context "with valid params" do

        it "should be able to return results listed by ratings" do
            get :search, params: { rating:true }
            expect(response).to have_http_status(200)
        end

        it "should be able to return results listed by location" do
            get :search, params: { location:true }
            expect(response).to have_http_status(200)
        end
    
        it "should be able to return results listed by name" do
            get :search, params: { name:true }
            expect(response).to have_http_status(200)
        end

        it "should be able to return results listed by all" do
            get :search, params: { all:true }
            expect(response).to have_http_status(200)
        end
    end
  end

  describe "GET #users" do

    context "with valid params" do
      it "should show a chefs page" do
        get :show, params: {id: valid_user.id}
        expect(response).to be_success
      end
    end
  end

  describe "GET #users" do

    context "with valid params" do
      it "should allow me to edit a chefs page" do
        get :edit, params: {id: valid_user.id}
        expect(response).to be_success
      end
  end

  describe "PUT #users" do
      it "should allow me to update a chefs page" do
        sign_in valid_user
        put :update, params: {id: valid_user.id, search: 'ox331pu', user: valid_attributes}
        #binding.pry
        expect(response).to be_success
      end
    end

    context "with invalid params" do
      it "should show not allow me to edit a chefs page" do
        put :update, params: {id: valid_user.id, illegal_param: 'test'}
        expect(response).not_to be_success
      end
    end
  end
      

  

end
