require "rails_helper"

RSpec.describe "Search_system", :type => :system do
  let(:valid_user){
    create(:user)
  }
  
  before do
    @gordon = User.create!(avatar: Rails.root.join("db/seed_images/gordon.jpg").open, email: 'gordonramsey@gmail.com', max_party_size: 10, price_per_head: 2000, is_a_chef:true, is_chef?: true, password: 'pass123', name: 'Gordon Ramsey', location_lat: 51.5033640,location_lon: -0.1276250, bio: 'Swears a lot and has numerous TV shows in both UK and America.\n Born 8 November 1966 is a British chef, restaurateur, and television personality. Born in Scotland, Ramsay grew up in Stratford-upon-Avon. His restaurants have been awarded 16 Michelin stars in total.[1][2] His signature restaurant, Restaurant Gordon Ramsay in Chelsea, London, has held three Michelin stars since 2001. First appearing on television in the UK in the late 1990s, by 2004 Ramsay had become one of the best known chefs in British popular culture, and, along with other chefs such as Jamie Oliver, Nigella Lawson, and Delia Smith, he has influenced viewers to become more culinarily adventurous.')
    @ainsley = User.create!(avatar: Rails.root.join("db/seed_images/ainsley.jpg").open, email: 'ainsleyharriet@gmail.com',max_party_size: 20, price_per_head: 800, is_a_chef:true, is_chef?: true, password: 'pass123', name: 'Ainsley Harriet', location_lat: 51.8745476,location_lon: -1.5338750, bio: 'Presenter for many BBC cooking shows.\n Ainsley Harriott (born 28 February 1957) is an English chef, television presenter, and entertainer. He is known for his BBC cooking shows Cant Cook, Wont Cook and Ready Steady Cook. ')
  end
  it "enables me to enter a postcode and get a list of chefs", js: true do
    visit '/' 
    fill_in 'user[postcode]', with: 'sl63ab'  
    click_button 'GO'
    sleep 2
    expect(page).to have_text(@gordon.name)
    take_screenshot
  end

  it "will not show me chefs that are out of range", js: true do
    visit '/' 
    fill_in 'user[postcode]', with: 'sl63ab'  
    click_button 'GO'
    sleep 2
    expect(page).not_to have_text(@ainsley.name)
  end

  it "will respond with location results when i click location", js: true do
    visit '/' 
    fill_in 'user[postcode]', with: 'sl63ab'  
    click_button 'GO'
    sleep 2
    page.execute_script %Q{"$('.container').find('#location').click()"}
    sleep 2
    expect(page).not_to have_text(@ainsley.name)
  end

  it "will redirect to home if postcode is incorrect", js: true do
    visit '/' 
    fill_in 'user[postcode]', with: 'xxxyyyy'  
    click_button 'GO'
    sleep 2
    expect(page).to have_current_path "/"
  end
end