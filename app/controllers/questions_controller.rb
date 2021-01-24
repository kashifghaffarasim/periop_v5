class QuestionsController < ApplicationController

    # Start Setting All Questions
    def index
        render json: Question.all
    end
end
