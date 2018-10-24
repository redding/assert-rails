require "assert"
require "assert-rails/adapter"

module AssertRails::Adapter

  class UnitTests < Assert::Context
    desc "AssertRails::Adapter"
    setup do
      @module = AssertRails::Adapter
    end
    subject{ @module }

  end

  class InitTests < UnitTests
    desc "when init"
    setup do
      adapter_class = Class.new do
        include AssertRails::Adapter
      end
      @adapter = adapter_class.new
    end
    subject{ @adapter }

    should have_imeths :reset_db

    should "not implement its adapter methods" do
      assert_raises(NotImplementedError){ subject.reset_db }
    end

  end

end
