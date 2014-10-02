class RulesController < ApplicationController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]

  around_filter :shopify_session

  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.all
    @products = ShopifyAPI::Product.find(:all)

  end

  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new  
    @rule = Rule.new
    @products = ShopifyAPI::Product.find(:all)
    @collections = ShopifyAPI::CustomCollection.find(:all)
  end

  # GET /rules/1/edit
  def edit
    @products = ShopifyAPI::Product.find(:all)
    @collections = ShopifyAPI::CustomCollection.find(:all)
    @selected_collections = []
    @selected_products = []
    for cid in @rule.collection_ids
      @selected_collections << @collections.find(:id=>cid).first
    end 
    for pid in @rule.product_ids
      @selected_products << @products.find(:id=>pid).first
    end
  end

  # POST /rules
  # POST /rules.json
  def create
=begin
{"utf8"=>"✓",
 "authenticity_token"=>"uhX0ExvsZktpN79dgGafYzmT8mcAsV1CiPGw/qwOMLg=",
 "rule"=>{"name"=>"new",
 "by_percentage"=>"true",
 "per_product"=>"1",
 "per_order"=>"2"},
 "product_ids"=>["368938147",
 "368938275"],
 "collection_ids"=>["28512115"],
 "commit"=>"Create Rule"}
=end

    rule_params.permit!

    @rule = Rule.new(rule_params)
    @rule.product_ids = params["product_ids"]
    @rule.collection_ids = params["collection_ids"]

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: "Rule was successfully created. #{params.to_s}" }
        format.json { render action: 'show', status: :created, location: @rule }
      else
        @products = ShopifyAPI::Product.find(:all)
        @collections = ShopifyAPI::CustomCollection.find(:all)
        format.html {render action: 'new' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
        rule_params.permit!

    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to @rule, notice: 'Rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to rules_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_params
      params[:rule]
    end
end
