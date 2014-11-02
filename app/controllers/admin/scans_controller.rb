class Admin::ScansController < ApplicationController
  before_action :set_scan, only: [:destroy]
  before_action :authenticate_admin!

  # GET /scans
  # GET /scans.json
  def index
    @scans = Scan.all
  end

  # DELETE /scans/1
  # DELETE /scans/1.json
  def destroy
    @scan.destroy
    respond_to do |format|
      format.html { redirect_to admin_scans_url, notice: 'Scan was successfully destroyed.' }
      format.json { head :no_content }
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
