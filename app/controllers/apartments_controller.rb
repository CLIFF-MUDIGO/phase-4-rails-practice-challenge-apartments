# app/controllers/apartments_controller.rb
class ApartmentsController < ApplicationController
    before_action :set_apartment, only: [:show, :update, :destroy]
  
    def index
      apartments = Apartment.all
      render json: apartments
    end
  
    def show
      render json: @apartment
    end
  
    def create
      apartment = Apartment.new(apartment_params)
  
      if apartment.save
        render json: apartment, status: :created
      else
        render json: { error: apartment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @apartment.update(apartment_params)
        render json: @apartment
      else
        render json: { error: @apartment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @apartment.destroy
      head :no_content
    end
  
    private
  
    def set_apartment
      @apartment = Apartment.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Apartment not found' }, status: :not_found
    end
  
    def apartment_params
      params.require(:apartment).permit(:number)
    end
  end
  