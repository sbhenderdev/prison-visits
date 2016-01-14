require 'rails_helper'
require 'mailers/shared_mailer_examples'

RSpec.describe VisitorMailer, '.booked' do
  let(:visit) { create(:booked_visit) }
  let(:mail) { described_class.booked(visit) }

  before do
    ActionMailer::Base.deliveries.clear
  end

  around do |example|
    travel_to Date.new(2015, 10, 1) do
      example.call
    end
  end

  include_examples 'template checks'

  it 'sends an email confirming the booking' do
    expect(mail.subject).
      to match(/your visit for Monday 12 October has been confirmed/)
  end

  it 'uses the locale of the visit' do
    visit.update locale: 'xx'
    expect(mail.subject).
      to match(/yoür visït för Mondäy 12 Octöber häs beën confïrmed/)
  end
end
