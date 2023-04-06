class ShipmentDecorator < BaseDecorator
  def register_button_text
    if recipients.include?(Current.recipient)
      "I'm in"
    elsif !orderable?
      'Out of Stock :('
    else
      'I want in'
    end
  end
end
