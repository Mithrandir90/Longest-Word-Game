class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @answer = params[:answer]
    @letters = params[:letter]
    @valid = if @answer.chars.all? { |letter| @answer.split('').count(letter) <= @letters.count(letter) } == false
                "Sorry but #{@answer.upcase} can't be built out of #{@letters}"
              elsif score_parsing(@answer) == false
                "Sorry but #{@answer.upcase} does not seem to be a valid English word..."
              else
                "Congratulation! #{@answer.upcase} is a valid English Word!"
              end
  end

  def score_parsing(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end
end



#{"message":"welcome","endpoints":["https://wagon-dictionary.herokuapp.com/:word","https://wagon-dictionary.herokuapp.com/autocomplete/:stem"
