class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show]

  # GET /candidates
  def index
    @candidates = Candidate.all
    render json: @candidates
  end

  # GET /candidates/1
  def show
    render json: @candidate
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end
end
