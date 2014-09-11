class Analyzer < ActiveRecord::Base
  belongs_to :user_info
  has_many :sub_analyzers

  def product(product_type)
    self.sub_analyzers.where(:product_type => product_type).first
  end
end
