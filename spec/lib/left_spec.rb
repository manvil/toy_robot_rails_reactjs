require 'spec_helper'
require 'parses_command'

RSpec.describe Left do
  let(:data) { { command: command, size: size, current_x: current_x, current_y: current_y, direction: direction } }
  let(:size) { 5 }
  let(:parse_command) { ParsesCommand.new(data) }
  subject { parse_command.parse }
  context 'left' do
    let(:command) { 'LEFT' }
    let(:current_x) { 0 }
    let(:current_y) { 0 }
    context 'rotate counter clockwise from north' do
      let(:direction) { 'north' }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should be successful' do
        expect(subject).to be_success
      end

      it 'should have result' do
        expect(subject).to respond_to(:result)
      end

      it 'result should be hash with valid data and should not move' do
        expect(subject.result).to be_a(Hash)
        expect(subject.result).to include(direction: 'west', current_x: current_x, current_y: current_y, report: nil)
      end
    end

    context 'rotate counter clockwise from east' do
      let(:direction) { 'east' }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should be successful' do
        expect(subject).to be_success
      end

      it 'should have result' do
        expect(subject).to respond_to(:result)
      end

      it 'result should be hash with valid data and should not move' do
        expect(subject.result).to be_a(Hash)
        expect(subject.result).to include(direction: 'north', current_x: current_x, current_y: current_y, report: nil)
      end
    end

    context 'rotate counter clockwise from south' do
      let(:direction) { 'south' }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should be successful' do
        expect(subject).to be_success
      end

      it 'should have result' do
        expect(subject).to respond_to(:result)
      end

      it 'result should be hash with valid data and should not move' do
        expect(subject.result).to be_a(Hash)
        expect(subject.result).to include(direction: 'east', current_x: current_x, current_y: current_y, report: nil)
      end
    end

    context 'rotate counter clockwise from west' do
      let(:direction) { 'west' }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should be successful' do
        expect(subject).to be_success
      end

      it 'should have result' do
        expect(subject).to respond_to(:result)
      end

      it 'result should be hash with valid data and should not move' do
        expect(subject.result).to be_a(Hash)
        expect(subject.result).to include(direction: 'south', current_x: current_x, current_y: current_y, report: nil)
      end
    end

    context 'invalid direction' do
      let(:direction) { 'somedir' }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should not be successful' do
        expect(subject).not_to be_success
      end

      it 'should have result' do
        expect(subject).to respond_to(:result)
      end

      it 'result should be hash with valid data and should not move' do
        expect(subject.result).to be_a(Hash)
        expect(subject.result).to include(error: 'Invalid direction')
      end
    end

    context 'invalid location' do
      let(:direction) { 'north' }
      let(:current_x) { nil }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should not be successful' do
        expect(subject).not_to be_success
      end

      it 'should have result' do
        expect(subject).to respond_to(:result)
      end

      it 'result should be hash with valid data and should not move' do
        expect(subject.result).to be_a(Hash)
        expect(subject.result).to include(error: 'Invalid placement')
      end
    end
  end
end
