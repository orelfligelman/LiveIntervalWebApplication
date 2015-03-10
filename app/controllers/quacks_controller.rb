require 'reloader/sse'


class QuacksController < ApplicationController
  before_action :set_quack, only: [:show, :edit, :update, :destroy]
  include ActionController::Live
  # GET /quacks
  # GET /quacks.json
  def index
    @quacks = Quack.all
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)
    begin
      directories = [
          File.join(Rails.root, 'app', 'assets'),
          File.join(Rails.root, 'app', 'views'),
      ]
      fsevent = FSEvent.new

      # Watch the above directories
      fsevent.watch(directories) do |dirs|
        # Send a message on the "refresh" channel on every update
        sse.write({ :dirs => dirs }, :event => 'refresh')
      end
      fsevent.run
      rescue IOError
      # When the client disconnects, we'll get an IOError on write
      ensure
      sse.close
      end
    end

  # GET /quacks/1
  # GET /quacks/1.json
  def show
  end

  # GET /quacks/new
  def new
    @quack = Quack.new
  end

  # GET /quacks/1/edit
  def edit
  end

  # POST /quacks
  # POST /quacks.json
  def create
    @quack = Quack.new(quack_params)

    respond_to do |format|
      if @quack.save
        format.html { redirect_to @quack, notice: 'Quack was successfully created.' }
        format.json { render :show, status: :created, location: @quack }
      else
        format.html { render :new }
        format.json { render json: @quack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quacks/1
  # PATCH/PUT /quacks/1.json
  def update
    respond_to do |format|
      if @quack.update(quack_params)
        format.html { redirect_to @quack, notice: 'Quack was successfully updated.' }
        format.json { render :show, status: :ok, location: @quack }
      else
        format.html { render :edit }
        format.json { render json: @quack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quacks/1
  # DELETE /quacks/1.json
  def destroy
    @quack.destroy
    respond_to do |format|
      format.html { redirect_to quacks_url, notice: 'Quack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quack
      @quack = Quack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quack_params
      params.require(:quack).permit(:name, :title)
    end
end
