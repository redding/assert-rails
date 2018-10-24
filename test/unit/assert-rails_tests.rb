require "assert"
require "assert-rails"

module AssertRails

  class UnitTests < Assert::Context
    desc "AssertRails"
    setup do
      @module = AssertRails
    end
    subject{ @module }

    should have_imeths :adapter
    should have_imeths :reset_db, :reset_db!

    should "set the DefaultAdapter as its adapter by default" do
      assert_instance_of DefaultAdapter, AssertRails.adapter
    end

    should "call to the adapter for its adapter methods" do
      assert_raises(NotImplementedError){ subject.reset_db }
    end

  end

  class ResetDbTests < UnitTests
    desc "when resetting the db"
    setup do
      @adapter_spy = AdapterSpy.new
      Assert.stub(AssertRails, :adapter){ @adapter_spy }
    end

    should "run adapter cmds to reset the db only once" do
      assert_equal [], @adapter_spy.cmds_called

      subject.reset_db

      exp = ["reset_db"]
      assert_equal exp, @adapter_spy.cmds_called

      subject.reset_db

      exp = ["reset_db"]
      assert_equal exp, @adapter_spy.cmds_called
    end

    should "force re-run adapter cmds to reset the db" do
      assert_equal [], @adapter_spy.cmds_called

      subject.reset_db!

      exp = ["reset_db"]
      assert_equal exp, @adapter_spy.cmds_called

      subject.reset_db!

      exp = ["reset_db", "reset_db"]
      assert_equal exp, @adapter_spy.cmds_called
    end

  end

  class DefaultAdapterTests < UnitTests
    desc "DefaultAdapter"
    setup do
      @class = DefaultAdapter
    end
    subject{ @class }

    should "mixin AssertRails::Adapter" do
      assert_includes AssertRails::Adapter, subject
    end

  end

  class AdapterSpy
    include AssertRails::Adapter

    attr_reader :cmds_called

    def initialize
      @cmds_called = []
    end

    def reset_db
      self.cmds_called << "reset_db"
    end

  end

end
