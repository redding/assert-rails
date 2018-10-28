require "assert"
require "assert-rails"

module AssertRails

  class DbTests < Assert::Context
    around do |block|
      AssertRails.transaction do
        block.call
        AssertRails.rollback!
      end
    end
  end

end
