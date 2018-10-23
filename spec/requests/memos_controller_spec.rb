require 'rails_helper'

RSpec.describe 'Memo API' do
  context 'Post / create' do
    let(:do_post) do
      post '/memos', params: { memo: memo_params }
    end

    context 'with attributes' do
      let(:memo_params) { attributes_for(:memo) }
      let(:latest_memo) { Memo.find(json_response['id']) }

      it 'creates new record' do
        expect { do_post }.to change { Memo.count }
      end

      it 'populates new memo with params' do
        do_post

        expect(latest_memo.title).to eq(memo_params[:title])
        expect(latest_memo.body).to eq(memo_params[:body])
      end

      it 'responds with success' do
        do_post

        expect(response).to be_success
        expect(response.code).to eq('200')
      end

      it 'returns the `id` of the created candidate' do
        do_post
        expect(json_response['id']).to be_present
      end
    end
  end
end
