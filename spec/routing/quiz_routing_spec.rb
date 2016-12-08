require 'rails_helper'

RSpec.describe QuizController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/quiz').to route_to('quiz#index')
    end

    it 'routes to #show' do
      expect(get: '/quiz/1').to route_to('quiz#show', id: '1')
    end

    it 'routes to #random' do
      expect(get: '/quiz/random').to route_to('quiz#random')
    end

    it 'routes to #answer' do
      expect(get: '/quiz/1/answer').to route_to('quiz#answer', id: '1')
    end
  end
end
