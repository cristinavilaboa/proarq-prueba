class FotosController < ApplicationController
  before_action :set_foto, only: [:show, :edit, :update, :destroy]
  before_action :set_proyecto

  # GET /fotos
  # GET /fotos.json
  def index
    @fotos = Foto.all
  end

  # GET /fotos/1
  # GET /fotos/1.json
  def show
  end

  # GET /fotos/new
  def new
    @foto = Foto.new
  end

  # GET /fotos/1/edit
  def edit
  end

  # POST /fotos
  # POST /fotos.json
  def create
	result = Cloudinary::Uploader.upload(foto_params[:src])
	@foto = @proyecto.fotos.build(foto_params) do |t|
        t.src = result['url']
		t.public_id = result['public_id']
    end
	if @foto.save
      redirect_to @proyecto
    else
      render :new
    end
  end

  # DELETE /fotos/1
  # DELETE /fotos/1.json
  def destroy
	Cloudinary::Api.delete_resources([@foto.public_id])
    @foto.destroy
    respond_to do |format|
      format.html { redirect_to @proyecto, notice: 'Foto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
	def set_proyecto
	  @proyecto = Proyecto.find(params[:proyecto_id])
	end
    # Use callbacks to share common setup or constraints between actions.
    def set_foto
      @foto = Foto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def foto_params
      params.require(:foto).permit(:descripcion, :src, :id, :es_portada)
    end
end
