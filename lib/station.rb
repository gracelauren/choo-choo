class Station < ActiveRecord::Base
  validates(:name, {:presence => true})
  has_and_belongs_to_many(:lines, {:uniq => true })
  before_save(:capitalize_name)
  validates_uniqueness_of :name

  default_scope { order('name') }

  define_method(:lines_not_added) do
    added = self.lines()
    not_added = Line.all() - added
    not_added
  end


  private

  define_method(:capitalize_name) do
    self.name = self.name().titlecase()
  end

end
