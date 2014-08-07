#encoding=utf-8
class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  after_action :discount_materials, only: [:create]
  before_action :recount_materials, only: [:destroy]

  # GET /histories
  # GET /histories.json
  def index
    @histories = History.paginate(page: params[:page], per_page: 7)
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    begin
      temp = History.get_random
      @history = temp.first
      @materials = temp.last
    rescue NoMethodError
      m = Material.limit 3
      @history = History.new
      @history.errors[:notice] = "没有足够的食材"
      @materials = m
    end
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(history_params)
    @ids = set_materials

    respond_to do |format|
      if @history.save
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.json { render action: 'show', status: :created, location: @history }
      else
        format.html { render action: 'new' }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:total_price)
    end

    def set_materials
      ids = params[:history][:material_ids].split(", ").map {|m| m.to_i}
      ids.each do |id|
        @history.his_mats.new material_id: id
      end

      ids
    end

    def discount_materials
      @ids.each do |id|
        material = Material.find id
        material.now -= material.cook_count
        material.save!
      end
    end

    def recount_materials
      @history.materials.each do |material|
        material.now += material.cook_count
        material.save!
      end
    end
end
