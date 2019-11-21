class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
    if current_user.id != @picture.user_id
      redirect_to pictures_path, notice: 'あなたの投稿ではありません。'
    end
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = current_user.pictures.build(picture_params)
    respond_to do |format|
      if params[:back]
        format.html { render :new }
      else
        if @picture.save
          format.html { redirect_to @picture, notice: '投稿しました' }
          format.json { render :show, status: :created, location: @picture }
        else
          format.html { render :new }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
          format.html { redirect_to @picture, notice: '投稿を編集しました' }
          format.json { render :show, status: :ok, location: @picture }
        else
          format.html { render :edit }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end
end
