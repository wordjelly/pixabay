require "typhoeus"
require "active_support/all"

class Pixabay::Base
	attr_accessor :api_key

	def initialize
		raise "no api key" unless ENV["PIXABAY_API_KEY"]
		raise "api key is blank" if ENV["PIXABAY_API_KEY"].strip.blank?
		self.api_key = ENV["PIXABAY_API_KEY"]
	end

	def base_url
		"https://pixabay.com"
	end

	def default_image_query_params
		{
		  	"key" => ENV["PIXABAY_API_KEY"],
		  	#"q" => "",
		  	"lang" => "en",
		  	#{}"id" => "",
		  	"image_type" => "all",
		  	"orientation" => "all",
		  	#{}"category" => "",
		  	"min_width" => 0,
		 	"min_height" => 0,
		  	#{}"colors" => "",
		  	"editors_choice" => false,
		  	"safesearch" => false,
		  	"order" => "popular",
		  	"page" => 1,
		  	"per_page" => 20,
		  	#{}"callback" => "",
		  	"pretty" => false
		}
	end

	
	def default_image_request_params
		{
			"url" => "/api/?",
			"method" => "GET",
			"headers" => {
				"Content-Type" => "application/json",
				"Accept" => "application/json"
			}
		}
	end

	## you can pass in args[:response] to stub out a respons for testing.
	## you can see different dummy response methods
	## image_search({"q" => "vomitting"})
	## @return[Hash] the response body json parsed. If the response code is non 200, will return an empty response. If raw == true, it will return the Typhoeus response object as is, for debugging.
	def image_search(query_params=default_image_query_params,request_params=default_image_request_params,raw=false)
		
		url = (base_url + request_params.delete("url")) + default_image_query_params.merge(query_params).to_param

		puts "url is #{url}"

		response = Typhoeus::Request.new(url,method: request_params["method"]).run

		puts "response code is #{response.code.to_s}"

		return response if raw 
	
		#return {} if response.code.to_s != "200"

		return JSON.parse(response.body)

	end
end
