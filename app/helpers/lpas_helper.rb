module LpasHelper
  def error_messages_for(object, field)
    '<span class="validation-message">' + object.errors.messages[field.to_sym].first + '</span>'
  end

  def input_for(form, label, options={}, html_options={}, &block)
    errors_present = form.object.errors.messages[label.to_sym].present?
    s = "<div class=\"group#{" validation" if errors_present}\">"
    if options[:label_override] != false
      s << form.label(label, :id => "#{label}_label") do
        x = options[:label_override] ? options[:label_override] : label.humanize
        x << error_messages_for(form.object, label) if errors_present
        raw(x)
      end
    else
      html_options[:class] = "#{html_options[:class]} push".strip
    end
    if block_given?
      s << raw(capture(&block))
    else
      s << raw(form.text_field label, html_options)
    end
    s << '</div>'
    raw s
  end

  def lpa_overview(lpa)
    @wizard_steps.collect { |s|
      if step_completed?(s) && text = self.send("#{s}_overview", lpa)
        [s, text]
      end
    }.compact
  end

  def type_overview(lpa)
    "This LPA covers #{lpa.type}"
  end

  def donor_overview(lpa)
    "The donor is #{lpa.donor.title} #{lpa.donor.first_name} #{lpa.donor.last_name}"
  end

  def people_to_be_told_overview(lpa)
    if lpa.people_to_be_told.size == 0
      "There are no 'people to be told'"
    elsif lpa.people_to_be_told.size == 1
      "The person to be told is #{lpa.people_to_be_told.first.full_name}"
    else
      "The people to be told are #{lpa.people_to_be_told.collect {|a| a.full_name}.to_sentence(:last_word_connector => ' and ')}"
    end
  end

  def certificate_provider_overview(lpa)
    "The certificate provider is #{lpa.certificate_provider.title} #{lpa.certificate_provider.first_name} #{lpa.certificate_provider.last_name}"
  end

  def certificate_provider2_overview(lpa)
    if lpa.certificate_provider2.present?
      "The second certificate provider is #{lpa.certificate_provider2.title} #{lpa.certificate_provider2.first_name} #{lpa.certificate_provider2.last_name}"
    end
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
      "The attorneys will act jointly for some decisions, and jointly and severally for other decisions"
    end
  end

  def how_replacement_attorneys_act_overview(lpa)
    if lpa.how_replacement_attorneys_act == "Jointly and Severally"
      "The replacement attorneys will act jointly and severally"
    elsif lpa.how_replacement_attorneys_act == "Jointly"
      "The replacement attorneys will act jointly"
    elsif lpa.how_replacement_attorneys_act == "Jointly for some decisions, and jointly and severally for other decisions"
      "The replacement attorneys will act jointly for some decisions, and jointly and severally for other decisions"
    end
  end

  def review_overview(lpa)
    nil
  end

  private
  def step_completed?(step_in_question)
    @wizard_steps.find_index(step_in_question) < @wizard_steps.find_index(step)
  end
end
