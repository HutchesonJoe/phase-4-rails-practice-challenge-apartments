class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response


  def index
    leases = Lease.all
    render json: leases
  end

  def create
    lease = Lease.create(lease_params)
    render json: lease, status: :created
  end

  def update
    lease = Lease.find_by!(id: params[:id])
    lease.update(lease_params)
    render json: lease, status: :updated
  end

  def destroy
    lease = Lease.find_by!(id: params[:id])
    lease.destroy
    render json: "Lease deleted."
  end

  private

  def lease_params
    params.permit(:rent, :tenant_id, :apartment_id)
  end

  def render_not_found_response(not_found)
    render json: { error: "Lease not found" }, status: :not_found
  end

  def record_invalid_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
  
end
