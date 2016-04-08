class HomeController < ApplicationController

	def index
		@posts = Post.all.where("post_type = :foo",{foo: 'posts' } ).order('created_at DESC')
	end
end
