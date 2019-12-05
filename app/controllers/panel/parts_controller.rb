class Panel::PartsController < ApplicationController
  require 'json'
  require 'rest-client'
  before_action :set_resource

  def index
    @parts = api_request('http://82.196.10.5:8081/sparepart/all')
    @parts_arr = []
    @parts.each do |p|
      @parts_arr.push( [ p[0], p[1], api_request("http://82.196.10.5:8082/pricelist/#{p[0]}") ] )
    end
  end

  def create_part
    new_part = api_post_request("http://82.196.10.5:8081/sparepart", { sparepart: params[:sparepart] })
    api_post_request("http://82.196.10.5:8082/pricelist", { id: new_part['id'], sparepartId: new_part['id'], sparepartName: params[:sparepart], price: params[:price] } )
    redirect_to panel_parts_path
  end

  def delete_part
    api_delete_request("http://82.196.10.5:8081/sparepart/#{params[:part_id]}")
    redirect_to panel_parts_path
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

  def api_delete_request(url)
    #params_string = params_to_send.to_query
    headers = { content_type: 'application/x-www-form-urlencoded' }
    send_delivery = RestClient.delete url, headers
  end
end
