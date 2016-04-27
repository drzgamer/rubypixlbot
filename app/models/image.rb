class Image < ActiveRecord::Base
    has_attached_file :image, styles: { thumbnail: "130x130#", small: "150x150", med: "300x300", large: "1024x1024" }, :path => ":rails_root/public/images/:year/:month/:id/:style/:basename.:extension", :url => "/images/:year/:month/:id/:style/:basename.:extension"
    do_not_validate_attachment_file_type :image
    
    before_create "default_title", "default_description"
    
    def image_url
        image.url(:thumbnail)
    end
    def image_size
        image.size
    end
    
    
    
    def default_title
        
        parts = self.image.original_filename.split(".");
        x = parts[0];

        self.title ||= x
    end
    
    def default_description
        self.description ||= " "
    end
end
