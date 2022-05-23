class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response

  def index
    tenants = Tenant.all
    render json: tenants
  end

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end

  def update
    tenant = Tenant.find_by!(id: params[:id])
    tenant.update(tenant_params)
    render json: tenant
  end

  def destroy
    tenant = Tenant.find_by!(id: params[:id])
    tenant.leases.destroy_all
    tenant.destroy
    render json: "Tenant deleted."
  end

  private

  def tenant_params
    params.permit(:name, :age)
  end


  def render_not_found_response(not_found)
    render json: { error: "Tenant not found" }, status: :not_found
  end

  def record_invalid_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
