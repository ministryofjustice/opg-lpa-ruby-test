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

  def lpa_overview(lpa)
    overview = @wizard_steps.collect {|s| self.send("#{s}_overview", lpa) if step_completed?(s)}.compact
    r = "<ul><li>"
    r << overview.join("</li><li>")
    r << "</li></ul>"
    raw r
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
