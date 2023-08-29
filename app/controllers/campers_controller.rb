class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    campers = Camper.all
    render json: campers
  end

  def show
    camper = Camper.find(params[:id])
    if camper
      render json: camper, include: :activities
    else
      render_not_found_response
    end
  end

  def create
    camper = Camper.create(name: params[:name], age: params[:age])
    if camper.valid?
      render json: camper, status: :created
    else
      render json: { errors: camper.errors.full_messages }, status: :unprocessable_entity
    end
  end

 private

    def render_not_found_response
      render json: { error: "Camper not found" }, status: :not_found
    end

end
