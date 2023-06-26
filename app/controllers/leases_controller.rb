# app/controllers/leases_controller.rb
class LeasesController < ApplicationController
    before_action :set_lease, only: [:destroy]
  
    def create
      lease = Lease.new(lease_params)
  
      if lease.save
        render json: lease, status: :created
      else
        render json: { error: lease.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @lease.destroy
      head :no_content
    end
  
    private
  
    def set_lease
      @lease = Lease.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Lease not found' }, status: :not_found
    end
  
    def lease_params
      params.require(:lease).permit(:rent, :apartment_id, :tenant_id)
    end
  