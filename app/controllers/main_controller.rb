class MainController < ApplicationController
  require 'json'
  require 'rest-client'
  before_action :set_resource

  def index
    #@vin = params[:vin]
    #@response = @fabric_client.query channel_id: 'firstchannel', chaincode_id: 'reestr', args: ['queryCar', @vin]
    @brands = api_request("http://82.196.10.5:8081/brand/all")

    p "brands after parse: #{@brands_arr } "
    @parts = api_request('http://82.196.10.5:8081/sparepart/all')
    

    # array = []
    # cars_hash = {}
    # @json_resp = @response.each_with_index do |resp, i|
    #   cars_hash["id"] = i
    #   cars_hash["name"] = resp
    #   p"hsh: #{cars_hash}"
    #   array.push(cars_hash)
    #   p"arr: #{array}"
    # end
  end

  def get_models
    @models = api_request("http://82.196.10.5:8081/model/brandid/#{params[:brand_id]}")
  end

  def order
    @client = params[:client]
    @master = api_request("http://82.196.10.5:8082/master/free")
    @brand = params[:brand]
    @model = params[:model]
    @parts_names = params[:parts_names].split(',').map.reject(&:blank?)
    p "parts_names: @parts_names"
    @parts = params[:parts].split(',').map.reject(&:blank?)
    @parts_arr = []
    @parts.each do |p|
      @parts_arr.push(api_request("http://82.196.10.5:8082/pricelist/#{p}"))
    end
    p "parts_arr: #{@parts_arr}"
    @sum = api_post_request("http://82.196.10.5:8082/pricelist/price/", @parts)
    p "sum: #{@sum}"
  end

  private
  def set_resource
    #@static_page = case action_name
    #when 'index' then StaticPage.new()
    #when 'show' then @company.static_pages.where(class_type: 'blog').find(params[:id])
    #end

    #check_cando(@static_page)

    #identity = Fabric::Identity.new Fabric.crypto_suite, private_key: ENV['FABRIC_CA_ADMIN_PK'], certificate: ENV['FABRIC_CA_ADMIN_CERT'], mspid: ENV['DEFAULT_MSPID']
    #@fabric_client = Fabric.client identity: identity
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
