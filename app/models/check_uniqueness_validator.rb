class CheckUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if ::User.where(email: value).exists?
      record.errors.add(attribute, :check_uniqueness, options.merge(value: value))
    end
  end
end

module ClientSideValidations::Middleware
  class User < Base
    def response
      if ::User.where(email: request.params[:email]).exists?
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end
