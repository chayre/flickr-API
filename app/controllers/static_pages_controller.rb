class StaticPagesController < ApplicationController
  require 'flickr'

  def home
    # Wait for user to submit user ID in params
    unless params[:id].nil?
      #  Format, flickr gem: flickr = Flickr.new "YOUR API KEY", "YOUR SHARED SECRET"
      flickr = Flickr.new ENV['flickr_key'], ENV['flickr_secret']
      begin
        # Get photos and store in @photos
        @photos = flickr.photos.search(user_id: params[:id], api_key: ENV['flickr_key'], per_page: 20)
      rescue Flickr::FailedResponse
        # Flash alert for FailedResponse
        flash[:alert] = 'User not found.'
      end
    end
  end
end