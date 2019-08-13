class ArrayInput
  include Formtastic::Inputs::Base

  def to_html
    input_wrapping do
      inputs = []

      @object[method].each_with_index do |v, x|
        inputs << array_input_html(v)
      end

      label_html <<
      template.content_tag(:div, class: 'input-group--array') do
        inputs.join.html_safe << array_input_html('', false)
      end
    end
  end

  private

    def array_input_html(value, remove=true)
      if remove
        button = template.content_tag(:button, template.fa_icon('minus-circle'), class: 'array-action--remove js-remove-from-array-input', type: 'button')
      else
        button = template.content_tag(:button, template.fa_icon('plus-circle'), class: 'array-action--add js-add-to-array-input', type: 'button')
      end
      template.content_tag(:div, class: 'input-group--array__item') do
        template.text_field_tag("#{object_name}[#{method}][]", value, id: nil) << button
      end
    end
end
