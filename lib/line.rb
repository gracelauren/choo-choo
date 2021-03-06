class Line < ActiveRecord::Base
  validates(:name, {:presence => true})
  has_and_belongs_to_many(:stations, {:uniq => true })
  before_save(:capitalize_name)
  validates_uniqueness_of :name

  define_method(:stations_not_added) do
    added = self.stations()
    not_added = Station.all() - added
    not_added
  end


  private

  define_method(:capitalize_name) do
    self.name = self.name().titlecase()
  end

end
