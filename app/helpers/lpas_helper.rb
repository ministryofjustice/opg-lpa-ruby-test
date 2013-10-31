module LpasHelper
  def error_messages_for(object, field)
    '<span class="validation-message">' + object.errors.messages[field.to_sym].join(", ") + '</span>'
  end

  def input_for(form, label, options={}, &block)
    errors_present = form.object.errors.messages[label.to_sym].present?
    s = "<div class=\"group#{" validation" if errors_present}\">"
    if options[:label_override] != false
      s << form.label(label, :id => "#{label}_label") do
        x = options[:label_override] ? options[:label_override] : label.humanize
        x << error_messages_for(form.object, label) if errors_present
        raw(x)
      end
    end
    s << raw(capture(&block))
    s << '</div>'
    raw s
  end

  def lpa_overview(lpa)
    overview = @wizard_steps.collect {|s| self.send("#{s}_overview", lpa) if step_completed?(s)}.compact
    if overview.present?
      r = "<ul><li>"
      r << overview.join("</li><li>")
      r << "</li></ul>"
      raw r
    else
      ""
    end
  end

  def type_overview(lpa)
    "This LPA covers #{lpa.type}"
  end

  def donor_overview(lpa)
    "The donor is #{lpa.donor.title} #{lpa.donor.first_name} #{lpa.donor.last_name}"
  end

  private
  def step_completed?(step_in_question)
    @wizard_steps.find_index(step_in_question) < @wizard_steps.find_index(step)
  end
end
