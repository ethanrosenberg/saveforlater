require 'time'
require 'uri'
require 'open-uri'

class DropboxController < ApplicationController

  def call
#azure vision?
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new

        response = image_annotator.label_detection(
          image: "https://storage.googleapis.com/saveforlater/AYsGu5VoTx6sjMJ5uFjfNKMn" )
          #max_results: 15 # optional, defaults to 10

        text = []
        response.responses.each do |res|
          #byebug
          res.label_annotations.each do |annotation|
            content = annotation.description.gsub(/\R+/, ' ').downcase
            text << content
          end
        end
byebug

  end



  def fetch

    results = []

    token = ENV["DROPBOX_OAUTH_BEARER"]
    #token = ENV["DROPBOX_OAUTH_BEARER"]
    #switch to icloud?
    client = DropboxApi::Client.new(token)

    result = client.list_folder '/photos'
    photos = result.entries

    photos.each do |item|
      link_data = client.get_temporary_link item.path_lower
      link = link_data.link
      screenshot = Screenshot.find_or_create_by(file_name: item.name)
        if !screenshot.image.attached?
          file = open(link_data.link)
          screenshot.image.attach(io: file, filename: item.name)
        else

          screenshot.client_modified = item.client_modified
          screenshot.image_url = link_data.link

        end


      #url.image.attach(io: downloaded_image, filename: "#{generate_activation_code(10)}-screenshot.png")
      screenshot.save
      #"2019-07-28T05:29:40Z".to_time
      results << screenshot
    end

    render json: results
  end


end
