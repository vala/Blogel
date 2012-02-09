module Blogel
  # to_slug method for String. Useful for clean URLs
  String.class_eval do
    def to_slug
      self.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end    
  end
end