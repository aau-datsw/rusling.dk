# Defines `self.has_json_editable(field_name, **options)` mimicking a has_many field, with a given value.
#
# @author [Frederik Spang Thomsen]
module HasJsonEditable
  def self.included(receiver)
    receiver.extend ClassMethods
  end

  module ClassMethods
    def has_json_editable(field_name, options = {})
      # include HasJsonEditable::InstanceMethods

      #  validate options here
      if options.fetch(:array, false)
        model_name  = "#{self.class.name}_#{field_name}"
        klass = eval(<<-KLASSSTRING
          Class.new do
            attr_accessor(#{options[:format].keys.map { |k| ":#{k}"}.join(', ')})
            def self.model_name
              '#{model_name}'
            end


            def initialize(attrs)
              #{options[:format].inspect}.each do |field, validator|
                # TODO: Generalize shit for validators, for `:string` instead of the lambda stuff, although its more flexible.
                self.instance_variable_set("@\#{field}", attrs[field.to_s]) # if validator.call(attrs[field.to_s])
              end
            end

            def [](attr)
              return self.send(attr.to_sym) if self.respond_to?(attr)
              nil
            end

            def persisted?() false; end
            def new_record?() false; end
            def marked_for_destruction?() false; end
            def _destroy() false; end
          end
        KLASSSTRING
        )

        define_method(field_name) do
          read_attribute(field_name).map { |obj| klass.new(obj) }
        end

        define_method("#{field_name}_attributes=") do |attributes|
          fields = []
          attributes.each do |index, attrs|
            next if '1' == attrs.delete("_destroy")
            options[:format].each do |field, _validator|
              attrs[field.to_s] = attrs[field.to_s] # TODO VARIABLE CASTING
            end
            fields << attrs
          end
          write_attribute(field_name, fields)
        end

        define_method("build_#{field_name}") do
          v = self.send(field_name).dup
          v << klass.new({})
          self.send("#{field_name}=", v)
        end
      else
        self.jsonb_accessor(field_name.to_sym, **options[:format])
      end
    end
  end
end
