# app/controllers/tenants_controller.rb
class TenantsController < ApplicationController
    before_action :set_tenant, only: [:show, :update, :destroy]
  
    def index
      tenants = Tenant.all
      render json: tenants
    end
  
    def show
      render json: @tenant
    end
  
    def create
      tenant = Tenant.new(tenant_params)
  
      if tenant.save
        render json: tenant, status: :created
      else
        render json: { error: tenant.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @tenant.update(tenant_params)
        render json: @tenant
      else
        render json: { error: @tenant.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @tenant.destroy
      head :no_content
    end
  
    private
  
    def set_tenant
      @tenant = Tenant.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Tenant not found' }, status: :not_found
    end
  
    def tenant_params
      params.require(:tenant).permit(:name, :age)
    end
  end
  