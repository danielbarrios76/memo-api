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

      it 'returns the id of the created memo' do
        do_post
        expect(json_response['id']).to be_present
      end
    end
  end

  context 'GET / index' do
    let(:element) { json_response.first }

    let(:do_get) do
      get '/memos'
    end

    context 'with exinting data' do
      let!(:memo) { create(:memo) }

      it 'lists the existing data' do
        do_get

        expect(json_response.size).to eq(Memo.count)
        expect(element['id']).to eq(memo.id)
        expect(element['title']).to eq(memo.title)
        expect(element['body']).to eq(memo.body)
      end

      it 'responds with success' do
        do_get

        expect(response).to be_success
        expect(response.code).to eq('200')
      end
    end

    context 'without data' do
      it 'returns an empty dataset' do
        do_get

        expect(json_response).to be_empty
      end

      it 'responds with success' do
        do_get

        expect(response).to be_success
        expect(response.code).to eq('200')
      end
    end
  end

  context 'GET /show' do
    let(:memo) { create(:memo) }

    let(:do_get) do
      get "/memos/#{memo.id}"
    end

    context 'with an existing memo' do
      it 'show memo' do
        do_get
        expect(json_response['id']).to eq(memo.id)
        expect(json_response['title']).to eq(memo.title)
        expect(json_response['body']).to eq(memo.body)
        
      end

      it 'responds with success' do
        do_get
        expect(response).to be_success
        expect(response.code).to eq('200')
      end
    end

    # context 'with an unexisting memo' do
    #   it 'responds with 404' do
    #     memo.id = 0
    #     do_get
    #     expect(response).to be_success
    #     expect(response.code).to eq('404')
    #   end
    # end
  end



  context 'PATCH /update' do
    let(:memo) { create(:memo) }
    let(:do_patch) do
      patch "/memos/#{memo.id}", params: { memo: memo_params }
    end

    context 'with valid attributes' do
      let(:memo_params) { attributes_for(:memo) }
      let(:update_memo) { Memo.find(json_response['id']) }

      it 'update the memo with the given params' do
        do_patch

        #expect(update_memo.id).to eq(memo_params[:id])
        expect(update_memo.title).to eq(memo_params[:title])
        expect(update_memo.body).to eq(memo_params[:body])
        expect(update_memo.complied).to eq(memo_params[:complied])
      end

      it 'responds with success' do
        do_patch

        expect(response).to be_success
        expect(response.code).to eq('200')
      end
      context 'PUT /comply' do
        let(:memo) { create(:memo) }
        let(:do_put) do
          put "/memos/#{memo.id}/comply"
        end
    
        context 'with a correct memo' do
          let!(:memo) { create(:memo) }
          it 'update complied attribute' do
            do_put
            expect(memo.reload).to be_complied
          end
    
          it 'responds with success' do
            do_put
    
            expect(response).to be_success
            expect(response.code).to eq('200')
          end
        end
    
      end
      it 'returns the `id` of the updated memo' do
        do_patch
        expect(json_response['id']).to be_present
      end
    end

    context 'with invalid params' do
      let(:memo_params) { attributes_for(:memo, title: nil, body: nil) }

      it 'responds with failure' do
        do_patch

        expect(response).not_to be_success
        expect(response.code).to eq('400')
      end
    end
  end

  context 'DELETE /destroy' do
    let(:memo) { create(:memo) }
    let(:do_delete) do
      delete "/memos/#{memo.id}"
    end

    context 'with an existing memo' do
      it 'responds with success' do
        do_delete

        expect(response).to be_success
        expect(response.code).to eq('200')
      end
    end
  end

  context 'PUT /comply' do
    let(:memo) { create(:memo) }
    let(:do_put) do
      put "/memos/#{memo.id}/comply"
    end

    context 'with a correct memo' do
      let!(:memo) { create(:memo) }
      it 'update complied attribute' do
        do_put
        expect(memo.reload).to be_complied
      end

      it 'responds with success' do
        do_put

        expect(response).to be_success
        expect(response.code).to eq('200')
      end
    end

  end
end
