require 'spec_helper'
require 'parses_command'

RSpec.describe Move do
  let(:data) { { command: command, size: size, current_x: current_x, current_y: current_y, direction: direction } }
  let(:size) { 5 }
  let(:parse_command) { ParsesCommand.new(data) }
  subject { parse_command.parse }
  context 'move' do
    let(:command) { 'MOVE' }
    context 'move on top edge' do
      let(:current_x) { 0 }
      let(:current_y) { 0 }
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
        expect(subject.result).to include(direction: direction, current_x: current_x, current_y: current_y, report: nil)
      end
    end

    context 'move on right edge' do
      let(:current_x) { 4 }
      let(:current_y) { 0 }
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
        expect(subject.result).to include(direction: direction, current_x: current_x, current_y: current_y, report: nil)
      end
    end

    context 'move when in middle' do
      let(:current_x) { 1 }
      let(:current_y) { 1 }
      context 'move north when in the middle' do
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
          expect(subject.result).to include(direction: direction, current_x: current_x, current_y: current_y - 1, report: nil)
        end
      end

      context 'move east when in the middle' do
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
          expect(subject.result).to include(direction: direction, current_x: current_x + 1, current_y: current_y, report: nil)
        end
      end

      context 'move south when in the middle' do
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
          expect(subject.result).to include(direction: direction, current_x: current_x, current_y: current_y + 1, report: nil)
        end
      end

      context 'move west when in the middle' do
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
          expect(subject.result).to include(direction: direction, current_x: current_x - 1, current_y: current_y, report: nil)
        end
      end
    end

    context 'with arguments' do
      let(:current_x) { 0 }
      let(:current_y) { 0 }
      let(:direction) { 'NORTH' }
      let(:command) { 'MOVE 1' }
      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should not be successful' do
        expect(subject).not_to be_success
      end

      it 'should have result' do
        expect(subject).to respond_to(:result)
      end

      it 'result should be hash with error' do
        expect(subject.result).to be_a(Hash)
        expect(subject.result).to include(error: 'Invalid arguments')
      end
    end
  end
end
