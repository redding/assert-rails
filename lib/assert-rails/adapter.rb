module AssertRails

  module Adapter

    def reset_db
      raise NotImplementedError
    end

    def transaction(&block)
      raise NotImplementedError
    end

    def rollback!
      raise NotImplementedError
    end

  end

end
