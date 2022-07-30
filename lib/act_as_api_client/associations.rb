# frozen_string_literal: true

module ActAsApiClient
  module Associations
    def has_many(connected_model, options)
      define_method connected_model.to_sym do

      end
    end
  end
end
