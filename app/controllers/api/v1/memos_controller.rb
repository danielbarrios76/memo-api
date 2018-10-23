class Api::V1::MemosController < Api::V1::ApiController
  def index
    @memos = Memo.all
    render json: @memos, status: 200
  end

  def create
    @memo = Memo.new(memo_params)
    if @memo.save
      render json: { 'id' => @memo.id }, status: 200
    else
      render json: @memo.errors, status: 400
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :body)
  end

  def current_memo
    @current_memo ||= Memo.find(params[:id])
  end
end
