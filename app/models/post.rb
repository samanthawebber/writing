require 'redcarpet'

class Post < ApplicationRecord
  has_many         :comments, dependent: :destroy
  has_one_attached :image

  def formatted_content
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(content).html_safe
  end
end
