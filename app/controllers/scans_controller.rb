class ScansController < ApplicationController
  before_action :set_scan, only: [:show]

  # GET /scans/1
  # GET /scans/1.json
  def show
  end

  # GET /scans/new
  def new
    @scan = Scan.new
  end

  # POST /scans
  # POST /scans.json
  def create
    @scan = Scan.new(scan_params)

    respond_to do |format|
      if @scan.save
        @scan.delay_process_dependencies!

        format.html { redirect_to @scan, notice: 'Scan was successfully created.' }
        format.json { render :show, status: :created, location: @scan }
      else
        format.html { render :new }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan
      @scan = Scan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scan_params
      params.require(:scan).permit(:gemfile)
    end
end
