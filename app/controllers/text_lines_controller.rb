# frozen_string_literal: true

class TextLinesController < ApplicationController
  def show
    @text_line = TextLine.find(params[:id])
  end
end
