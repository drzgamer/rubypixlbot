class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  layout "dashboard"
  # GET /images
  # GET /images.json
  def index
    if params[:image_search_id]
      @images = Image.find_by('id = ?', params[:image_search_id])
      
      @imagearray = Array.new
      
 
        @imagearray << {
          :id => @images.id,
          :title => @images.title,
          :description => @images.description,
          :created_at => @images.created_at,
          :image_size => @images.image.size,
          :image_url => @images.image.url(:thumbnail)}

    else  
      @images = Image.paginate(:page => params[:page], :per_page => 30).order('id DESC')
      @form = params[:form]
    end
    respond_to do |format|  
      format.html # index.html.erb  
      # Here is where you can specify how to handle the request for "/people.json"
      format.json { render :json => @images.as_json(:only => [:id, :title, :description ,:created_at], :methods => [:image_url,:image_size]) }
    end
    
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    print "THESE ARE THE PARAMS"
    print params[:images]
    
    params[:post_attachments]['avatar'].each do |a|
          @image = Image.create!(:image => a, :title => "", :description => "")
    end

    redirect_to root_url + "dashboard/images", notice: 'Image was successfully created.'

  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:title, :description, :image)
    end
end
