
#  $('#pricing').text(gon.vl.groups[0].items[rest_index].venue.price.message)
#  $('#type').text(gon.vl.groups[0].items[rest_index].venue.categories[0].name)


#<p>Logged in as: <%= @current_user[:username] %></p>
class RandomSwipesController < ApplicationController

  #:v=> '20170901'

  def show
    begin
      @user = Rails.application.config.user
    rescue
      redirect_to login_path
    end
    if not defined? @user
      puts "@user is not defined"
      redirect_to login_path
    else



      get_location()


      @venue_search = Foursquare2::Client.new(:client_id => 'SEIMTTT2VYZF0GQW45R4FBCU3Y2PXVAKP0BZRM3QTG1QGWM1', :client_secret => 'RPIHNXPALRNNX4ZG55SKFDOXH5NHCKZ3ZUKEZ1JKXDIZS0WA', :v=> '20170901').explore_venues(:ll => '%s,%s' % [@zipcode[0],@zipcode[1]], :section => 'food',:v=> '20170901')
      v = return_rest()
      @name_ = @venue_search.groups[0][:items][v][:venue][:name]

      gon.vl = @venue_search
      gon.length_ = return_rest()
      gon.watch.name_ = @name_
      #!!! venue_search.groups[0][:items][0][:venue]
      #venue_search.groups[0][:items][0][:venue][:name]
      #                               ^ Change for different restraunt\

      @price = @venue_search.groups[0][:items][v][:venue][:price][:message]
      gon.watch.price = @price

      @venuetype = @venue_search.groups[0][:items][v][:venue][:categories][0][:name] #venue type
      gon.watch.venuetype = @venuetype

      rest_lat_lng = [@venue_search.groups[0][:items][v][:venue][:location][:lat],@venue_search.groups[0][:items][v][:venue][:location][:lng]]

      @dist = Geocoder::Calculations.distance_between(@zipcode,rest_lat_lng)
      gon.watch.dist = @dist
      for i in 0..40
        puts '\n'
      end


      render 'random_card_view'
    end
  end

  def return_rest
    z = Rails.application.config.user[:zip]
    @zipcode = Geocoder.coordinates(z)
    venue_search = Foursquare2::Client.new(:client_id => 'SEIMTTT2VYZF0GQW45R4FBCU3Y2PXVAKP0BZRM3QTG1QGWM1', :client_secret => 'RPIHNXPALRNNX4ZG55SKFDOXH5NHCKZ3ZUKEZ1JKXDIZS0WA', :v=> '20170901').explore_venues(:ll => '%s,%s' % [@zipcode[0],@zipcode[1]], :section => 'food',:v=> '20170901')
    vl = venue_search.groups

    return rand(vl[0][:items].length)
  end


  def get_location

    z = Rails.application.config.user[:zip]
    @zipcode = Geocoder.coordinates(z)
  end

  def get_data

    data_array = ['hello']
    respond_to do |format|
        format.html
        format.json { render json: data_array }
    end
  end

  def update_text
    v = return_rest()
    z = Rails.application.config.user[:zip]
    zipcode = Geocoder.coordinates(z)
    @venue_search = Foursquare2::Client.new(:client_id => 'SEIMTTT2VYZF0GQW45R4FBCU3Y2PXVAKP0BZRM3QTG1QGWM1', :client_secret => 'RPIHNXPALRNNX4ZG55SKFDOXH5NHCKZ3ZUKEZ1JKXDIZS0WA', :v=> '20170901').explore_venues(:ll => '%s,%s' % [@zipcode[0],@zipcode[1]], :section => 'food',:v=> '20170901')
    @name_ = @venue_search.groups[0][:items][v][:venue][:name]
    @price = @venue_search.groups[0][:items][v][:venue][:price][:message]
    @venuetype = @venue_search.groups[0][:items][v][:venue][:categories][0][:name]
    rest_lat_lng = [@venue_search.groups[0][:items][v][:venue][:location][:lat],@venue_search.groups[0][:items][v][:venue][:location][:lng]]
    @dist = Geocoder::Calculations.distance_between(@zipcode,rest_lat_lng)
    puts @name_
    puts @price
    puts @venuetype
    puts @dist

    data_array = [@name_,@price,@venuetype,@dist]
    respond_to do |format|
        format.html
        format.json { render json: data_array }
    end
  end



helper_method :update_text

end
