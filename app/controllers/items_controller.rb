class ItemsController < ApplicationController
  
  before_filter :require_user
  before_filter :require_list
  
  def require_list
    if params[:list_id]
      @list = List.find(params[:list_id])
    end
  end
  
  # GET /items
  # GET /items.json
  def index
    # get items from the parent list
    @items = @list.items
    # create a new item for the ajax form to use
    @item = Item.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    # This...
    @item = @list.items.build(params[:item])
    # ...does the same as this
    # @item = Item.new(params[:item])
    # @item.list = @list
    
    respond_to do |format|
      if @item.save
        format.js 
        format.html { redirect_to list_url(@list), notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to list_path(@list) }
      format.json { head :ok }
    end
  end
end
