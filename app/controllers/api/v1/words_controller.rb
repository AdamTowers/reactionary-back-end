module Api
  module V1

    class WordsController < ApplicationController
      def random
        @word = Word.getRandomWord

        render json: @word
      end
    end

  end
end
