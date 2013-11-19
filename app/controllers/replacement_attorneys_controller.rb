class ReplacementAttorneysController < AttorneysController

  skip_before_filter :verify_authenticity_token, :only => [:destroy]

  def attorney_relation
    :replacement_attorneys
  end

end
