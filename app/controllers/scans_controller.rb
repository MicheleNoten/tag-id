class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :edit, :update, :destroy]

  def index
    @scans = Scan.all
  end

  def new
    @scan = Scan.new
  end

  def show
    @scan.set_gpt_response if @scan.photo.attached? && @scan.response_chatgpt.nil?
  end

  def edit
  end

  # POST /scans or /scans.json
  def create
    @scan = Scan.new(video_params)
    @scan.user = current_user

    respond_to do |format|
      if @scan.save
        puts "Scan was successfully created. Fetching GPT response..."
        @scan.set_gpt_response if @scan.photo.attached? && @scan.response_chatgpt.nil?
        if valid_hash_string?(@scan.response_chatgpt)
          scan_fabric_composition = JSON.parse(@scan.response_chatgpt)

          puts "Scan fabric composition is not empty. Creating new product..."
          @product = Product.new
          @product.scan = @scan
          @product.user = current_user
          @product.category = Category.second

          # TODO: Convert response_chatgpt to JSON and save in product
          scan_fabric_composition = JSON.parse(@scan.response_chatgpt)
          @product.brand = scan_fabric_composition["brand"]
          @product.made_in = scan_fabric_composition["origin_country"]
          @product.save!
          puts "Product saved!"

          # Create product fabric composition
          puts "Creating product fabric composition..."
          # TODO: Save fabric composition in product
          scan_fabric_composition["fabric_composition"].each do |fabric, value|
            puts "#{fabric}: #{value}"

            if Fabric.search_by_name("polyester recycled").first
              @fabricComposition = ProductFabric.new
              @fabricComposition.product = @product
              @fabricComposition.fabric_percent = value.gsub('%', '').to_i
              @fabricComposition.fabric = Fabric.search_by_name("polyester recycled").first
              p @fabricComposition
              if @fabricComposition.save!
                puts "Product fabric composition saved!"
              end
            end
          end

          # Redirection
          format.html { redirect_to root_path, notice: "Scan was successfully created." }
          format.json { render json: { scan_status: 'PRODUCT_SUCCESS', redirect_to: edit_product_path(@product) } }
        else
          puts "Scan fabric composition is empty. Redirecting to new product page..."
          format.html { redirect_to root_path, notice: "Scan was successfully created. Product creation failed" }
          format.json { render json: { scan_status: 'PRODUCT_FAILED', redirect_to: new_product_path } }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scans/1 or /scans/1.json
  def update
    respond_to do |format|
      @scan.set_gpt_response if @scan.photo.attached?
      if @scan.update(video_params)
        format.html { redirect_to scan_path(@scan), notice: "Scan was successfully updated." }
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

  def valid_hash_string?(str)
    begin
      result = eval(str)
      result.is_a?(Hash)
    rescue SyntaxError, NameError
      false
    end
  end

  def set_scan
    @scan = Scan.find(params[:id])
  end

  def video_params
    params.require(:scan).permit(:photo)
  end
end
