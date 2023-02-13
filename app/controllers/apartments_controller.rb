class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid


    def index
        apartments = Apartment.all
        render json: apartments, status: :ok
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(permitted_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(permitted_params)
        render json: apartment, status: :accepted
    end
    
    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy!
        render json: [], status: :no_content
    end

    private

    def render_record_not_found
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def render_record_invalid(invalid)
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
    end


    def permitted_params
        params.permit(:number)
    end
end
