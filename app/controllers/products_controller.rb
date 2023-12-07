class ProductsController < ApplicationController
  def index
    @products = current_user.products
  end

  def show
    @products = Product.all
    @product = Product.find_by_id(params[:id])

    if @product
      scores = @product.product_fabrics.map { |product_fabric| product_fabric.fabric_percent/100.0 * product_fabric.fabric.weighted_average_score }
      @average = scores.present? ? (scores.sum / scores.count) : 0
    else
      redirect_to root_path, alert: 'Product not found'
    end
  end

  def new
    @product = Product.new
  end

  def add_to_wardrobe
    @product = Product.find(params[:id])
    @wardrobe = Wardrobe.find_by(user_id: current_user.id)
    unless @wardrobe.products.include?(@product)
      @wardrobe.products << @product
  end
    redirect_to wardrobe_path(@wardrobe)
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    @product.brand_logo = fetch_brand_logo(@product.brand)
    if @product.save
      params.require(:product).permit(:counter)[:counter].to_i.times do |index|
        fabric_type_params = params["fabric_type_#{index + 1}"]
        fabric_composition_params = params["fabric_composition_#{index + 1}"]
        fabric = Fabric.find_by_name(fabric_type_params.downcase)
        ProductFabric.create(product: @product, fabric: fabric, fabric_percent: fabric_composition_params)
      end
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @@refer = request.referer
  end

  def update
    @product = Product.find(params[:id])
    remove_deleted_items(@product, params[:product][:deleted_items]) unless params[:product][:deleted_items].nil?

    if @product.update(product_params)
      @product.brand_logo = fetch_brand_logo(@product.brand)
      @product.save!
      # @product.product_fabrics.destroy_all
      params[:product][:counter].to_i.times do |index|
        fabric_type_params = params["fabric_type_#{index + 1}"]
        fabric_composition_params = params["fabric_composition_#{index + 1}"]
        fabric = Fabric.find_by_name(fabric_type_params&.downcase)
        # check if product fabric exists
        @product_fabric = ProductFabric.find_by(product: @product, fabric: fabric)
        if @product_fabric
          @product_fabric.update(fabric_percent: fabric_composition_params)
        else
          @product.product_fabrics.create!(
            fabric: fabric,
            fabric_percent: fabric_composition_params
          ) unless fabric_type_params.blank? && fabric_composition_params.blank?
        end
      end
      redirect_to product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def remove_deleted_items(product, deleted_items_list)
    deleted_items = deleted_items_list.split(',')
    deleted_items.each do |item|
      product.product_fabrics.each do |product_fabric|
        product_fabric.destroy if product_fabric.fabric.name == item
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully deleted.'
  end

  def fetch_brand_logo(brand_name)
    brand_name = brand_name.gsub(' ', '%20')
    # Fetch brand icon
    url = URI("https://api.brandfetch.io/v2/search/#{brand_name}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Referer"] = 'https://example.com/searchIntegrationPage'

    response = http.request(request)

    # Parse the JSON response
    response_data = JSON.parse(response.read_body)

    # Extract the icon URL and save it to a variable
    if response_data[0]
      icon_url = response_data[0]["icon"]
    else
      icon_url = "https://res.cloudinary.com/dclsbfntj/image/upload/v1701940740/production/rwoqhe6qqed7m21y78ku.png"
    end
  end

  private

  def product_params
    params.require(:product).permit(:counter, :deleted_items, :item_name, :made_in, :brand, :purchased_in, :certification_label, :comments,
                                    :description, :score, :category_id, :scan_id, :user_id, :brand_logo, photos: [])
  end

  def fabric_types
    params.require(:fabric_types).permit(fabric_types: [])
  end
end
