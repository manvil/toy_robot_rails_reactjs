require 'rails_helper'

RSpec.describe 'Command Parsing', type: :request do
  context 'given Place command' do
    context 'given valid arguments' do
      before do
        post command_path, params: { command: { command: 'Place 1,1,NORTH', current_x: 0, current_y: 0, size: 5 } }
      end
      it 'should be a postiive response' do
        expect(response).to have_http_status(:ok)
      end

      it 'should have valid data' do
        expect(json_body[:direction]).to eq('north')
        expect(json_body[:current_x]).to eq(1)
        expect(json_body[:current_y]).to eq(3)
        expect(json_body[:report]).to be_nil
      end
    end

    context 'given invalid arguments' do
      before do
        post command_path, params: { command: { command: 'Place 1,1,1' } }
      end
      it 'should be a negative response' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'should have valid data' do
        expect(json_body[:error]).to eq('Invalid arguments')
      end
    end
  end

  context 'given Move command' do
    context 'given valid arguments' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'MOVE', current_x: 0, current_y: 4, size: 5 } }
      end
      it 'should be a postiive response' do
        expect(response).to have_http_status(:ok)
      end

      it 'should have valid data' do
        expect(json_body[:direction]).to eq('north')
        expect(json_body[:current_x]).to eq(0)
        expect(json_body[:current_y]).to eq(3)
        expect(json_body[:report]).to be_nil
      end
    end

    context 'given invalid arguments' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'MOVE 1,1', current_x: 0, current_y: 4, size: 5 } }
      end
      it 'should be a negative response' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'should have valid data' do
        expect(json_body[:error]).to eq('Invalid arguments')
      end
    end
  end

  context 'given LEFT command' do
    context 'given valid arguments' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'LEFT', current_x: 0, current_y: 4, size: 5 } }
      end
      it 'should be a postiive response' do
        expect(response).to have_http_status(:ok)
      end

      it 'should have valid data' do
        expect(json_body[:direction]).to eq('west')
        expect(json_body[:current_x]).to eq(0)
        expect(json_body[:current_y]).to eq(4)
        expect(json_body[:report]).to be_nil
      end
    end

    context 'given invalid arguments' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'LEFT 1,1', current_x: 0, current_y: 4, size: 5 } }
      end
      it 'should be a negative response' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'should have valid data' do
        expect(json_body[:error]).to eq('Invalid arguments')
      end
    end
  end

  context 'given RIGHT command' do
    context 'given valid arguments' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'RIGHT', current_x: 0, current_y: 4, size: 5 } }
      end
      it 'should be a postiive response' do
        expect(response).to have_http_status(:ok)
      end

      it 'should have valid data' do
        expect(json_body[:direction]).to eq('east')
        expect(json_body[:current_x]).to eq(0)
        expect(json_body[:current_y]).to eq(4)
        expect(json_body[:report]).to be_nil
      end
    end

    context 'given invalid arguments' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'RIGHT 1,1', current_x: 0, current_y: 4, size: 5 } }
      end
      it 'should be a negative response' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'should have valid data' do
        expect(json_body[:error]).to eq('Invalid arguments')
      end
    end
  end

  context 'given REPORT command' do
    context 'given valid arguments' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'REPORT', current_x: 0, current_y: 4, size: 5 } }
      end
      it 'should be a postiive response' do
        expect(response).to have_http_status(:ok)
      end

      it 'should have valid data' do
        expect(json_body[:report]).to eq('0,0,NORTH')
      end
    end

    context 'given invalid arguments' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'REPORT 1,1', current_x: 0, current_y: 4, size: 5 } }
      end
      it 'should be a negative response' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'should have valid data' do
        expect(json_body[:error]).to eq('Invalid arguments')
      end
    end

    context 'given invalid position' do
      before do
        post command_path,
             params: { command: { direction: 'NORTH', command: 'REPORT', size: 5 } }
      end
      it 'should be a negative response' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'should have valid data' do
        expect(json_body[:error]).to eq('Invalid placement')
      end
    end
  end
end
