class PingsController < ApplicationController

    # Database Checking Connections
    def show
        begin
          render json: Mongoid::Sessions.default.command(ping: 1)
        rescue Moped::Errors::ConnectionFailure
          render json: {error: "Database connection failure"}, status: :service_unavailable
        end
    end
end
