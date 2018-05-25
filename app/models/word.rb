class Word < ApplicationRecord
  def getRandomWord
    Word.all.sample
  end
end
