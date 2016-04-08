class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
	layout "dashboard"
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end
  
  
  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end
  
  


  # POST /posts
  # POST /posts.json
  def create
	assign_params = post_params.dup;
	assign_params.delete(:getcat)
    @post = Post.new(assign_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
	  
	  assign_params = post_params.dup;
	  assign_params.delete(:getcat)
	  
	  @post.updatecat(post_params[:getcat])
	  
	  print assign_params
	  print post_params
      if @post.update(assign_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:category, :post_type, :author, :date, :title, :content, :excerpt, :status, :name, :lastedit, :getcat)
    end
end
