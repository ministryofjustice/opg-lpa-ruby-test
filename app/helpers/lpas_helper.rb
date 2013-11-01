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
    @wizard_steps.collect {|s| self.send("#{s}_overview", lpa) if step_completed?(s)}.compact
  end

  def type_overview(lpa)
    "This LPA covers #{lpa.type}"
  end

  def donor_overview(lpa)
    "The donor is #{lpa.donor.title} #{lpa.donor.first_name} #{lpa.donor.last_name}"
  end

  def when_to_use_overview(lpa)
    if lpa.type == "Property and financial affairs"
      "The LPA can be used #{lpa.when_to_use}"
    else
      nil
    end
  end

  def life_sustaining_overview(lpa)
    if lpa.type == "Health and welfare"
      if lpa.life_sustaining_treatment == "Option A"
        "The attorneys can make decisions about life-sustaining treatment on the donor's behalf"
      elsif lpa.life_sustaining_treatment == "Option B"
        "The attorneys can't make decisions about life-sustaining treatment on the donor's behalf"
      end
    else
      nil
    end
  end

  def attorneys_overview(lpa)
    if lpa.attorneys.size == 1
      "The attorney is #{lpa.attorneys.first.full_name}"
    else
      "The attorneys are #{lpa.attorneys.collect {|a| a.full_name}.to_sentence(:last_word_connector => ' and ')}"
    end
  end

  def replacement_attorneys_overview(lpa)
    if lpa.replacement_attorneys.size == 1
      "The replacement attorney is #{lpa.replacement_attorneys.first.full_name}"
    else
      "The replacement attorneys are #{lpa.replacement_attorneys.collect {|a| a.full_name}.to_sentence(:last_word_connector => ' and ')}"
    end
  end

  def how_attorneys_act_overview(lpa)
    if lpa.how_attorneys_act == "Jointly and Severally"
      "The attorneys will act jointly and severally"
    elsif lpa.how_attorneys_act == "Jointly"
      "The attorneys will act jointly"
    elsif lpa.how_attorneys_act == "Jointly for some decisions, and jointly and severally for other decisions"
      "The replacement attorneys will act jointly for some decisions, and jointly and severally for other decisions"
    end
  end

  private
  def step_completed?(step_in_question)
    @wizard_steps.find_index(step_in_question) < @wizard_steps.find_index(step)
  end
end
