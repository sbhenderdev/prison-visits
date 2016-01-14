class BookingRequestsController < ApplicationController
  helper FormElementsHelper

  def index
    processor = StepsProcessor.new(params, I18n.locale)
    @steps = processor.steps
    render processor.template_name
  end

  def create
    processor = StepsProcessor.new(params, I18n.locale)
    processor.execute!
    @steps = processor.steps
    render processor.template_name
  end

private

  def prison
    @steps.fetch(:prisoner_step).prison
  end
  helper_method :prison

  def reviewing?
    params.key?(:review_step)
  end
  helper_method :reviewing?
end
