class RulesController < ApplicationController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]
  around_filter :shopify_session
  before_action :calculate_all, only: [:show]


  def pay
    @rule = Rule.find(params[:id])
    paid = @rule.raised - @rule.paid_amount
    @rule.paid_amount = @rule.raised

 
    @rulepay = Rulepay.new(:identifier => ShopifyAPI::Shop.current.email)
    @rulepay.name = @rule.name
    @rulepay.starting_date = @rule.starting_date
    @rulepay.ending_date = Time.now
    @rulepay.amount = paid
    
    @rule.save 
    @rulepay.save

    redirect_to '/payments'

  end

  def notifications

    @rules = Rule.where(:identifier => ShopifyAPI::Shop.current.email)    
    @orders = ShopifyAPI::Order.find(:all)
    @products = ShopifyAPI::Product.find(:all)
    @collections = get_collections
    @amounts = []
    @shop = Shop.find(session[:shopify])

  end
  


  def payments
    @rules = Rule.where(:identifier => ShopifyAPI::Shop.current.email)
    @rulepays = Rulepay.where(:identifier => ShopifyAPI::Shop.current.email)  
  end

  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.where(:identifier => ShopifyAPI::Shop.current.email)   
    @products = ShopifyAPI::Product.find(:all)
    @collections = get_collections

  end

  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new  
    @rule = Rule.new
    @products = ShopifyAPI::Product.find(:all)
    @collections = get_collections
    @tags = []
    for p in @products 
      if !p.tags.nil?
        if p.tags.include?(",")  
          for t in p.tags.split(",")
            @tags << t
          end 
        else 
          @tags<<p.tags
        end
      end
    end
    @tags = @tags.uniq
  end

  # GET /rules/1/edit
  def edit
    @products = ShopifyAPI::Product.find(:all)
    @collections = get_collections
    @tags = []
    for p in @products 
      if !p.tags.nil?
        if p.tags.include?(",")  
          for t in p.tags.split(",")
            @tags << t
          end 
        else 
          @tags<<p.tags
        end
      end
    end
    @tags = @tags.uniq
    @selected_collections = []
    @selected_products = []
    if !@rule.collection_ids.nil?  
            for cid in @rule.collection_ids
              for c in @collections
                if c.id.to_i == cid.to_i
                  @selected_collections << c
                end
              end
            end 
          end
          if !@rule.product_ids.nil?
            for pid in @rule.product_ids
              for p in @products
                if p.id.to_i == pid.to_i
                  @selected_products << p
                end
              end
            end
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
    @rule.tags = params["tags"]
    @rule.identifier = ShopifyAPI::Shop.current.email
    @rule.domain = ShopifyAPI::Shop.current.domain
    calculate_raised_amount(@rule)

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: "Rule was successfully created." }
        format.json { render action: 'show', status: :created, location: @rule }
      else
        @products = ShopifyAPI::Product.find(:all)
        @collections = get_collections
        @tags = []
        for p in @products 
          if !p.tags.nil?
            if p.tags.include?(",")  
              for t in p.tags.split(",")
                @tags << t
              end 
            else 
              @tags<<p.tags
            end
          end
        end
         @selected_collections = []
          @selected_products = []
          if !@rule.collection_ids.nil?  
            for cid in @rule.collection_ids
              for c in @collections
                if c.id.to_i == cid.to_i
                  @selected_collections << c
                end
              end
            end 
          end
          if !@rule.product_ids.nil?
            for pid in @rule.product_ids
              for p in @products
                if p.id.to_i == pid.to_i
                  @selected_products << p
                end
              end
            end
          end
        format.html {render action: 'new' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    rule_params.permit!
    @rule.product_ids = params["product_ids"]
    @rule.collection_ids = params["collection_ids"]
    @rule.tags = params["tags"]
      @rule.identifier = ShopifyAPI::Shop.current.email
  
    @products = ShopifyAPI::Product.find(:all)
    @collections = get_collections
    calculate_raised_amount(@rule)
    
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

  def total_amount
    shop = Shop.where("domain =?",params[:domain]).first
    @total = 0
    for r in Rule.where(:identifier=>shop.email)
      @total = @total + r.raised
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @total.to_json }
    end
  end 

  private

    def get_collections
      collections = ShopifyAPI::CustomCollection.find(:all)
      smart_collections = ShopifyAPI::SmartCollection.find(:all)
      collections = collections.to_a
      for sc in smart_collections
        collections << sc
      end
      return collections
    end




    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_params
      params[:rule]
    end

    def calculate_all
      for r in Rule.where(:identifier=>ShopifyAPI::Shop.current.email)
        calculate_raised_amount(r)
      end
    end

    def calculate_raised_amount(rule)
      @orders = ShopifyAPI::Order.find(:all)
      @products = ShopifyAPI::Product.find(:all)
      @collections = get_collections
      @rule = rule
      @amount = 0.0
      @raised_product_ids = []
      #filter orders
      if !@rule.product_ids.nil?
        @raised_product_ids = @rule.product_ids.map{|id| id.to_i}
      end

      if !@rule.collection_ids.nil?
        for cid in @rule.collection_ids
                for c in @collections
                  if c.id.to_i == cid.to_i
                    for p in c.products
                      if !@raised_product_ids.include?(p.id) 
                       @raised_product_ids << p.id
                      end
                    end
                 end
            end
        end 
      end

      if !@rule.tags.nil?
        for t in @rule.tags
          for p in @products
            if !p.tags.nil?
             if p.tags.include?(",")  
              for tag in p.tags.split(",")
                if tag == t && !@raised_product_ids.include?(p.id) 
                  @raised_product_ids << p.id
                end
              end
             elsif p.tags == t && !@raised_product_ids.include?(p.id) 
                  @raised_product_ids << p.id
             end
            end
          end
        end

      end


      
        for o in @orders
          if (o.cancelled_at.nil? && @rule.permanent == true && @rule.created_at.to_datetime < o.updated_at.to_datetime ) || (o.cancelled_at.nil? && o.updated_at.to_datetime > @rule.starting_date && o.updated_at.to_datetime < @rule.ending_date)
            if @rule.per_order!=nil
              @amount = @amount + (@rule.by_percentage ? (@rule.per_order.to_f/100)*o.total_line_items_price.to_f : @rule.per_order.to_f )
            else
              for item in o.line_items 
                if @raised_product_ids.include?(item.product_id)
                  @amount = @amount + (@rule.by_percentage ? (@rule.per_product.to_f/100)*(item.price.to_f)*(item.quantity.to_f) : (@rule.per_product.to_f)*(item.quantity.to_f)) 
                end
              end
            end
          end
        end

        @rule.raised = @amount
        @rule.save
    end

end
