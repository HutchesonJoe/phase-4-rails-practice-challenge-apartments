class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response

  def index
    apartments = Apartment.all 
    render json: apartments
  end

  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  def destroy
    apartment = Apartment.find_by!(id: params[:id])
    apartment.leases.destroy_all
    apartment.destroy
  end

  private

  def apartment_params
    params.permit(:number)
  end
  def render_not_found_response(not_found)
    render json: { error: "Apartment not found" }, status: :not_found
  end

  def record_invalid_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
