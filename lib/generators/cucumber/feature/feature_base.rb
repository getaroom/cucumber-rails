module Cucumber
  module Generators
    module FeatureBase

      def create_directory(m = self, rails2 = false)
        dir = 'features/step_definitions'

        if rails2
          m.directory dir
        else
          m.empty_directory dir unless File.directory?(dir)
        end
      end

      def create_feature_file(m = self)
        m.template 'feature.erb', "features/manage_#{plural_name}.feature"
      end

      def create_steps_file(m = self)
        m.template 'steps.erb', "features/step_definitions/#{singular_name}_steps.rb"
      end

      def create_support_file(m = self)
        m.gsub_file 'features/support/paths.rb', /'\/'/mi do |match|
          "#{match}\n    when /the new #{singular_name} page/\n      new_#{singular_name}_path\n"
        end
      end

    end
  end
end
