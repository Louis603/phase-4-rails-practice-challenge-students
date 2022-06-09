class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :error_unprocessable

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = Student.find!(params[:id])
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = Student.find!(params[:id])
        student.destroy
        head :no_content
    end

    private

    def error_not_found
        render json: { error: "Not found" }, status: :not_found
    end

    def error_unprocessable
        render json: { error: "Must include name and age must be 18 or older" }, status: :unprocessable_entity
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
