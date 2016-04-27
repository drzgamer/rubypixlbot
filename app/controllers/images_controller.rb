class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_filter :set_layout, :only => [:index]
  # GET /images
  # GET /images.json
  def index
    @images = Image.paginate(:page => params[:page], :per_page => 50).order('id DESC')
    @form = params[:form]
      
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
    @image = Image.create(image_params)

  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    
    if params[:_method]
      print params
      @image = Image.find(params[:id])
      
      @image.title = params[:title]
      @image.description = params[:description]
      @image.save
      respond_to do |format|
        format.js if request.xhr?
        format.html {render :nothing => true, status: 200}
      end
    else
      respond_to do |format|
      if @image.update(params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
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
    def set_layout
      if params[:form] == "insert"
        self.class.layout "image"
      else
        self.class.layout "dashboard"
      end
        
      
    end
    
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:title, :description, :image)
    end
end
