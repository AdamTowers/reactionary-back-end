class Word < ApplicationRecord
  def self.getRandomWord
    Word.all.sample
  end
end
