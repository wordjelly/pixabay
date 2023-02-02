# frozen_string_literal: true

require "test_helper"

class TestPixabay < Minitest::Test
  def test_image_search
    pb = Pixabay::Base.new
    images = pb.image_search({"q" => "yellow+flower","per_page" => 1},pb.default_image_request_params)
  end
end
