class Manufacturer < ActiveRecord::Base
    has_many :bikes

    def to_s                
        "|id:#{self.id.to_s.ljust(6)} |mnfct name:#{self.name.ljust(30)} |url:#{self.url}\n"
      end
end