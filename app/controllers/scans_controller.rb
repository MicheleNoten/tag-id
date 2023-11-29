class ScansController < ApplicationController

  def new
    @scan = Scan.new
  end

  # POST /scans or /scans.json
  def create
    @scan = Scan.new(video_params)

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

  private

  def video_params
    params.require(:scan).permit(:photo)
  end
end
