class Api::V1::VersionController < Api::V1::ApiController
  def show
    render json: { 'version' => Api::V1::ApiController::VERSION }, status: 200
  end
end
