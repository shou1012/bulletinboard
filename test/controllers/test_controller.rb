class TestController < ApplicationController
  protect_from_forgery :except => [:sample]

  def sample
    ## 処理
  end
end
