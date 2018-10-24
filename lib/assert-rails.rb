require "assert-rails/version"

module AssertRails

  def self.adapter(instance = nil)
    @adapter = instance if !instance.nil?
    @adapter
  end

  def self.reset_db
    @reset_db ||= begin
      self.reset_db!
      true
    end
  end

  def self.reset_db!
    self.adapter.reset_db
  end

  class DefaultAdapter
    include AssertRails::Adapter

  end

  self.adapter(DefaultAdapter.new)

end
