require 'csv'

module Admin
  class RecipientExportController < Admin::BaseController
    def show
      respond_to do |format|
        format.html
        format.csv do
          send_data Recipient.to_csv,
                    filename: "mailing-list-recipients-#{DateTime.now.strftime('%d%m%Y%H%M')}.csv"
        end
      end
    end
  end
end
