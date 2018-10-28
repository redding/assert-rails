require "assert"
require "assert-rails/db_tests"

class AssertRails::DbTests

  class UnitTests < Assert::Context
    desc "AssertRails::DbTests"
    setup do
      @transaction_called = false
      Assert.stub(AssertRails, :transaction) do |&block|
        @transaction_called = true
        block.call
      end

      @rollback_called = false
      Assert.stub(AssertRails, :rollback!) do
        @rollback_called = true
      end

      @class = AssertRails::DbTests
    end
    subject{ @class }

    should "be an Assert context" do
      assert subject < Assert::Context
    end

    should "add an around callback to run tests in a rollback transaction" do
      assert_equal 1, subject.arounds.size
      callback = subject.arounds.first

      block_yielded_to = false
      callback.call(proc{ block_yielded_to = true })

      assert_true @transaction_called
      assert_true @rollback_called
      assert_true block_yielded_to
    end

  end

end
