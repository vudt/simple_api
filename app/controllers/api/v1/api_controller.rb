module Api::V1
  class ApiController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
    rescue_from ActiveRecord::RecordNotSaved, with: :render_record_not_saved_response
    rescue_from ActiveRecord::RecordNotDestroyed, with: :render_record_not_destroyed_response
    rescue_from ActiveRecord::RecordNotUnique, with: :render_record_not_unique_response

    def render_record_invalid_response(e)
      render json: ErrorHandler.new(e, 422).generate, status: 422
    end

    def render_record_not_found_response(e)
      render json: ErrorHandler.new(e, 404).generate, status: 404
    end 

    def render_record_not_saved_response(e)
      render json: ErrorHandler.new(e, 422).generate, status: 422
    end

    def render_record_not_destroyed_response(e)
      render json: ErrorHandler.new(e, 422).generate, status: 422
    end

    def render_record_not_unique_response(e)
      render json: ErrorHandler.new(e, 422).generate, status: 422
    end
  end
end