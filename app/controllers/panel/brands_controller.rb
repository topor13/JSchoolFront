class Panel::BrandsController < ApplicationController

  require 'json'
  require 'rest-client'
  before_action :set_resource

  def index
    @brands = api_request("http://82.196.10.5:8081/brand/all")

    @parts = api_request('http://82.196.10.5:8081/sparepart/all')
  end

  def get_models
    @models = api_request("http://82.196.10.5:8081/model/brandid/#{params[:brand_id]}")
  end

  def delete_brand
  end


  private
  def set_resource

  end

  def list_params
    params.require(:main_page).permit(:brand, :model, :parts, :parts_names, :brand_id, :client)
  end

  def api_request(url)
    #params_string = params_to_send.to_query
    headers = { content_type: 'application/x-www-form-urlencoded' }
    send_delivery = RestClient.get url, headers

    p "parts body: #{send_delivery}"
    JSON.parse(send_delivery.body)
  end

  def api_post_request(url, payload)
    #params_string = params_to_send.to_query
    headers = { content_type: 'json' }
    p "req_head: #{headers}"
    p "req_body: #{payload}"
    p "req_url: #{url}"
    send_delivery = RestClient.post url, (payload).to_json, headers
    p "parts body: #{send_delivery}"
    JSON.parse(send_delivery.body)
  end

end
