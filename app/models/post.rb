class Post < ActiveRecord::Base
	has_many :catrelations
	has_many :catagories, through: :catrelation
	
	def to_param
		name
	end
	
	def getcat
		@ids = Catrelation.where(post_id: self.id).all
		
		foo = ""
		counter = 0
		@ids.each  do |post|
			
			if counter == 0
				foo = foo + post.category_id.to_s
			else
				foo = foo + "," + post.category_id.to_s 
			end
			counter += 1
			
		end
		return foo
	end
	
	def updatecat(cats)
		catarry = cats.split(",")
		Catrelation.where(post_id: self.id).delete_all
		catarry.each do |catter|
				Catrelation.create(post_id: self.id, category_id: catter)
            
		end
	end
	
	def cleanparams(dezparams)
		a_params = dezparams.dup;
		a_params.delete(:getcat)
	  
		updatecat(dezparams[:getcat])
		
		if a_params[:name] = ""
			if a_params[:title] != ""
				a_params[:name] = (((a_params[:title].strip).gsub(/[^a-zA-Z 0-9]/, "")).gsub(/\s/,'_')).downcase
			else
				a_params[:name] = "post-" + self.id.to_s
			end
		end

		return a_params
		
	end
	
	def posttype
		if self.post_type == "posts"
			return self.root_path + "/posts"
		end

	end	
	
end
