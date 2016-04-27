class Post < ActiveRecord::Base
	has_many :catrelations
	has_many :categories, through: :catrelations
	has_many :post_meta
	
	# uses name in url instead of id
	def to_param
		name
	end
	
	# retrieves cat
	def getcat
		return self.category_ids.join(",")
	end
	
	#retrives source
	def getsource
		foo = post_meta.find_by(meta_key: "_source")
		if foo
			return foo.meta_value
		else
			return nil
		end

	end
	
	def updatecat(cats)
		self.category_ids = cats.split(",")
		
	end
	
	def updatesource(source)
	    foo = post_meta.find_by(meta_key: "_source")
	    if foo
	      foo.meta_value = source
	      foo.save
	    else
	      post_meta.create(meta_key: "_source" , meta_value: source)
	    end
	end
	
	
	def cleanparams(dezparams,mainparams)
		a_params = dezparams.dup;
		a_params.delete(:getcat)
		a_params.delete(:getsource)
		
		updatecat(mainparams[:categories_params])
		updatesource(dezparams[:getsource])
		
		if a_params[:name] = ""
			if a_params[:title] != ""
				a_params[:name] = (((a_params[:title].strip).gsub(/[^a-zA-Z 0-9]/, "")).gsub(/\s/,'_')).downcase
			else
				a_params[:name] = "post-" + self.id.to_s
			end
		end
	
		if mainparams[:status_button] == "Publish"
		  a_params[:status] = "Publish"
		else
		  a_params[:status] = "Draft"
		end

		return a_params
		
	end
	
	def posttype
		if self.post_type == "posts"
			return self.root_path + "/posts"
		end

	end	
	
end
