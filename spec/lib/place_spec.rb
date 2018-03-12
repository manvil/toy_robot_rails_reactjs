require 'spec_helper'
require 'parses_command'

RSpec.describe Place do
  let(:data) { { command: command, size: size, current_x: current_x, current_y: current_y, direction: direction } }
  let(:size) { 5 }
  let(:parse_command) { ParsesCommand.new(data) }
  subject { parse_command.parse }
  context 'place' do
    context 'valid data' do
      context 'without previous data' do
        let(:command) { 'PLACE 0,0,NORTH' }
        let(:direction) { nil }
        let(:current_x) { nil }
        let(:current_y) { nil }

        it 'should not raise error' do
          expect { subject }.not_to raise_error
        end

        it 'should be successful' do
          expect(subject).to be_success
        end

        it 'should have result' do
          expect(subject).to respond_to(:result)
        end

        it 'result should be hash with valid data' do
          expect(subject.result).to be_a(Hash)
          expect(subject.result).to include(direction: 'north', current_x: 0, current_y: 4, report: nil)
        end
      end

      context 'with previous data' do
        let(:command) { 'PLACE 1,1,EAST' }
        let(:direction) { nil }
        let(:current_x) { nil }
        let(:current_y) { nil }

        it 'should not raise error' do
          expect { subject }.not_to raise_error
        end

        it 'should be successful' do
          expect(subject).to be_success
        end

        it 'should have result' do
          expect(subject).to respond_to(:result)
        end

        it 'result should be hash with valid data' do
          expect(subject.result).to be_a(Hash)
          expect(subject.result).to include(direction: 'east', current_x: 1, current_y: 3, report: nil)
        end
      end
    end

    context 'invalid data' do
      context 'positive out of bounds' do
        let(:command) { 'PLACE 5,5,NORTH' }
        let(:direction) { nil }
        let(:current_x) { nil }
        let(:current_y) { nil }
        subject { ParsesCommand.new(data).parse }

        it 'should not raise error' do
          expect { subject }.not_to raise_error
        end

        it 'should not be successful' do
          expect(subject).not_to be_success
        end

        it 'should have result' do
          expect(subject).to respond_to(:result)
        end

        it 'result should be hash with error data' do
          expect(subject.result).to be_a(Hash)
          expect(subject.result).to include(error: 'Invalid arguments')
        end
      end

      context 'negative out of bounds' do
        let(:command) { 'PLACE -1,3,NORTH' }
        let(:direction) { nil }
        let(:current_x) { nil }
        let(:current_y) { nil }
        subject { ParsesCommand.new(data).parse }

        it 'should not raise error' do
          expect { subject }.not_to raise_error
        end

        it 'should not be successful' do
          expect(subject).not_to be_success
        end

        it 'should have result' do
          expect(subject).to respond_to(:result)
        end

        it 'result should be hash with error data' do
          expect(subject.result).to be_a(Hash)
          expect(subject.result).to include(error: 'Invalid arguments')
        end
      end

      context 'incorrect direction' do
        let(:command) { 'PLACE 3,4,SOMEDIR' }
        let(:direction) { nil }
        let(:current_x) { nil }
        let(:current_y) { nil }
        subject { ParsesCommand.new(data).parse }

        it 'should not raise error' do
          expect { subject }.not_to raise_error
        end

        it 'should not be successful' do
          expect(subject).not_to be_success
        end

        it 'should have result' do
          expect(subject).to respond_to(:result)
        end

        it 'result should be hash with error data' do
          expect(subject.result).to be_a(Hash)
          expect(subject.result).to include(error: 'Invalid arguments')
        end
      end

      context 'invalid direction' do
        let(:direction) { nil }
        let(:current_x) { nil }
        let(:current_y) { nil }
        subject { ParsesCommand.new(data).parse }

        context 'empty arguments' do
          let(:command) { 'PLACE' }

          it 'result should be hash with error data' do
            expect(subject.result).to be_a(Hash)
            expect(subject.result).to include(error: 'Invalid arguments')
          end
        end
        context 'invalid argument length' do
          let(:command) { 'PLACE 1,1,1,NORTH' }

          it 'result should be hash with error data' do
            expect(subject.result).to be_a(Hash)
            expect(subject.result).to include(error: 'Invalid arguments')
          end
        end

        context 'less arguments' do
          let(:command) { 'PLACE 1,1' }

          it 'result should be hash with error data' do
            expect(subject.result).to be_a(Hash)
            expect(subject.result).to include(error: 'Invalid arguments')
          end
        end
      end
    end
  end
end
