class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :edit, :update, :destroy]

  def index
    @scans = Scan.all
  end

  def new
    @scan = Scan.new
  end

  def show
  end

  def edit
  end

  # POST /scans or /scans.json
  def create
    @scan = Scan.new(video_params)
    @scan.user = current_user

    respond_to do |format|
      if @scan.save
        format.html { redirect_to scan_url(@scan), notice: "Scan was successfully created." }
        format.json { render :show, status: :created, location: @scan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scans/1 or /scans/1.json
  def update
    respond_to do |format|
      if @scan.update(video_params)
        format.html { redirect_to scan_url(@scan), notice: "Scan was successfully updated." }
        format.json { render :show, status: :ok, location: @scan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scans/1 or /scans/1.json
  def destroy
    @scan.destroy!

    respond_to do |format|
      format.html { redirect_to scans_url, notice: "Scan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_scan
    @scan = Scan.find(params[:id])
  end

  def video_params
    params.require(:scan).permit(:photo)
  end
end
