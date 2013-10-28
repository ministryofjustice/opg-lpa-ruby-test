module LpasHelper
  def error_messages_for(object, field)
    object.errors.messages[field.to_sym].join(", ")
  end

  def input_for(form, label, &block)
    s = '<div class="group">'
    s << form.label(label) do
      raw label.humanize + capture(&block)
    end
    s << error_messages_for(form.object, label)
    s << '</div>'
    raw s
  end
end
