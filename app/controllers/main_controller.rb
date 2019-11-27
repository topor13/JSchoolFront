class MainController < ApplicationController
  require 'json'
  require 'rest-client'
  before_action :set_resource

  def index
    #@vin = params[:vin]
    #@response = @fabric_client.query channel_id: 'firstchannel', chaincode_id: 'reestr', args: ['queryCar', @vin]
    @brands = api_request("http://82.196.10.5:8081/brand/all")
    @parts = api_request('http://82.196.10.5:8081/sparepart/all')
    @models = api_request('http://82.196.10.5:8081/model/all')

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

  def order
    @brand = params[:brand]
    @model = params[:model]
    @parts = params[:parts]
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
    params.require(:main_page).permit(:brand, :model, :parts)
  end

  def api_request(url) #, params_to_send)
    #params_string = params_to_send.to_query
    headers = { content_type: 'application/x-www-form-urlencoded' }

    send_delivery = RestClient.get url, headers
    p "parts body: #{send_delivery}"
    JSON.parse(send_delivery.body)
  end
end
