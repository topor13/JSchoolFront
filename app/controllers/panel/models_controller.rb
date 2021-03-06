class Panel::ModelsController < ApplicationController

  require 'json'
  require 'rest-client'
  before_action :set_resource

  def index
    @brands = api_request("http://82.196.10.5:8081/brand/all").collect { |k,v| [ k, v ] }
    @brands_invert = []
    @brands.each do |b|
      @brands_invert.push( b.reverse )
    end
    @models = []
    @brands.each do |b|
      api_request("http://82.196.10.5:8081/model/brandid/#{b[0]}").each do |m|
        @models.push( { brand: b[1], model: m } )
      end
    end
    @parts = api_request('http://82.196.10.5:8081/sparepart/all')
  end

  def get_models
    @models = api_request("http://82.196.10.5:8081/model/brandid/#{params[:brand_id]}")
  end

  def create_model
    model = api_post_request("http://82.196.10.5:8081/model", { model: params[:model_name] } )
    api_post_request("http://82.196.10.5:8081/links", { modelId: model['id'], brandId: params[:brand_id] } )
    redirect_to panel_models_path
  end

  def delete_model
    redirect_to panel_models_path
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
