class MainPageController < ApplicationController
  require 'json'
  require 'rest-client'
  before_action :set_resource

  def index
    #@responses = @fabric_client.query channel_id: 'firstchannel', chaincode_id: 'reestr', args: ['queryAllCars']
    #@responses = api_request("https://api.github.com/users/{params[:vin]}")
    #@jsonResp = JSON.parse @responses.first
  end

  def search
    @vin = params[:vin]
    #@response = @fabric_client.query channel_id: 'firstchannel', chaincode_id: 'reestr', args: ['queryCar', @vin]
    @response = api_request("https://api.github.com/users/#{@vin}")
    @json_resp = @response
  end

  def new
  end

  def create
    #@fabric_client.invoke channel_id: 'firstchannel', chaincode_id: 'reestr', args: [
    #  'createCar',        params[:vin],      params[:model],
    #  params[:color],     params[:owner],    params[:number]
    #]
    redirect_to root_path
  end

  def new_crash
    @vin = params[:vin]
  end

  def add_crash
    #@fabric_client.invoke channel_id: 'firstchannel', chaincode_id: 'reestr', args: [
    #  'addCrashToCar',        params[:vin],        params[:vinOthers],
    #   params[:damages],      params[:crashdate]
    #]
    redirect_to root_path
  end

  def repair
    #@fabric_client.invoke channel_id: 'firstchannel', chaincode_id: 'reestr', args: ['repairCar', params[:vin], params[:position]]
    redirect_to root_path
  end

  def pay
    #@fabric_client.invoke channel_id: 'firstchannel', chaincode_id: 'reestr', args: ['payRepair', params[:vin], params[:position]]
    redirect_to root_path
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
      params.require(:main_page).permit(:vin, :model, :color, :owner, :number, :damages, :crashdate, :vinOthers)
    end

    def api_request(url) #, params_to_send)
      #params_string = params_to_send.to_query
      headers = { content_type: 'application/x-www-form-urlencoded' }

      send_delivery = RestClient.get url, headers

      JSON.parse(send_delivery.body)
    end
end
