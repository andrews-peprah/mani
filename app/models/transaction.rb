class Transaction < ApplicationRecord

  # Generates csv format of this data
  def self.to_csv(attributes)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        # select fields from the attributes and create
        # csv file
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
    
  end

end
