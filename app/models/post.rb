class Post < ActiveRecord::Base
	has_many :catrelations
	has_many :catagories, through: :catrelation
	
	
	def getcat
		@ids = Catrelation.where(post_id: self.id).all
		
		hello = ""
		counter = 0
		@ids.each  do |post|
			
			if counter == 0
				hello = hello + post.category_id.to_s
			else
				hello = hello + "," + post.category_id.to_s 
			end
			counter += 1
			
		end
		print hello
		return hello
	end
	
	def updatecat(cats)
		catarry = cats.split(",")
		Catrelation.where(post_id: self.id).delete_all
		catarry.each do |catter|
				Catrelation.create(post_id: self.id, category_id: catter)
            
		end
	end
	
end
