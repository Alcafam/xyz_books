class IsbnSearch
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :search

    validates_length_of :search, :maximum => 10

    def initialize(attributes = {})
        attributes.each do |name, value|
            send("#{name}=", value)
        end
    end

    def persisted?
        false
    end
end
