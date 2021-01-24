class AssessmentsController < ApplicationController

   before_action :authenticate_user!, except: :create

    def index
        res = Assessment.all
        if params[:sort] == 'created_at'
        res = res.desc('created_at')
        else
        res = res.desc('date_of_surgery')
        end
        res = res.search params[:term] if params[:term].present?
        res = res.where(state: params[:state]) if params[:state].present?
        res = res.page(params[:page]).per(10)
        render json: res, each_serializer: AssessmentSerializer, meta: {
        total_count: res.total_count,
        total_pages: res.total_pages,
        current_page: res.current_page
        }
    end

    def show
        assessment = Assessment.find params[:id]
        render json: assessment
    end

    # TODO: show error for patient
    def create
        assessment = Assessment.create params.require(:assessment).permit!
        NotificationMailer.assessment_created(assessment).deliver_now
        render json: assessment
    end

    def update
        assessment = Assessment.find params[:id]
        assessment.update params.permit(:comment, :state)
        render json: assessment
    end
end
