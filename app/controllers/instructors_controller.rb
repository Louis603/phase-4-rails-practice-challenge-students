class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
rescue_from ActiveRecord::RecordInvalid, with: :error_unprocessable

    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def error_not_found
        render json: { error: "Not found" }, status: :not_found
    end

    def error_unprocessable
        render json: { error: "Must include name" }, status: :unprocessable_entity
    end

    def instructor_params
        params.permit(:name)
    end
end
