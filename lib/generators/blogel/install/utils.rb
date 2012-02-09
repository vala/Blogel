module Blogel
  module Generators
    module Utils
      module InstanceMethods
        def do_say str, color = :green
          say "[ Blogel ] #{str}", color
        end
      end
    end
  end
end