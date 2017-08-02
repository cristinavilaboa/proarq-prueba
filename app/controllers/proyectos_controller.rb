class ProyectosController < ApplicationController
  before_action :set_proyecto, only: [:show, :edit, :update, :destroy, :deleteportada]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /proyectos
  # GET /proyectos.json
  def index
    @proyectos = Proyecto.all
  end

  # GET /proyectos/1
  # GET /proyectos/1.json
  def show
	@fotos = @proyecto.fotos
  end

  # GET /proyectos/new
  def new
    @proyecto = Proyecto.new
  end

  # GET /proyectos/1/edit
  def edit
  end
  
  # POST /proyectos/1/deleteportada
  def deleteportada
	Cloudinary::Api.delete_resources([@proyecto.portada_id])
	@proyecto.portada = ''
	@proyecto.portada_id = ''
	respond_to do |format|
	  if @proyecto.save
		  if @proyecto.portada.blank?
			format.html { redirect_to @proyecto, notice: 'Portada was successfully deleted.' }
			format.json { render :show, status: :created, location: @proyecto }
		  end
	  end
	end
  end

  # POST /proyectos
  # POST /proyectos.json
  def create
	if !proyecto_params[:portada].blank?
		result = Cloudinary::Uploader.upload(proyecto_params[:portada])
		@proyecto = Proyecto.new(proyecto_params) do |t|
			t.portada = result['url']
			t.portada_id = result['public_id']
		end
	end
    respond_to do |format|
      if @proyecto.save
        format.html { redirect_to @proyecto, notice: 'Proyecto was successfully created.' }
        format.json { render :show, status: :created, location: @proyecto }
      else
        format.html { render :new }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proyectos/1
  # PATCH/PUT /proyectos/1.json
  def update
	id = @proyecto.id
	pp = proyecto_params
	if !proyecto_params[:portada].blank?
		result = Cloudinary::Uploader.upload(proyecto_params[:portada])
		pp[:portada] = result['url']
		pp[:portada_id] = result['public_id']
	end
	puts(pp[:portada_id])
	respond_to do |format|
      if @proyecto.update(pp)
        format.html { redirect_to proyecto_path(id), notice: 'Proyecto was successfully updated.' }
        format.json { render :show, status: :ok, location: @proyecto }
      else
        format.html { render :edit }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyectos/1
  # DELETE /proyectos/1.json
  def destroy
	if !@proyecto.portada.blank?
		Cloudinary::Api.delete_resources([@proyecto.portada_id])
	end
    @proyecto.destroy
    respond_to do |format|
      format.html { redirect_to proyectos_url, notice: 'Proyecto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proyecto
      @proyecto = Proyecto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proyecto_params
      params.require(:proyecto).permit(:titulo, :tramite, :ubicacion, :descripcion, :fecha, :portada, :portada_id)
    end
end
