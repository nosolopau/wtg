class Scan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :gemfile, type: String

  has_many :dependencies

  validate :gemfile, presence: true

  after_save :set_dependencies

  def set_dependencies
    self.dependencies = Dependency.create_from_gemfile(self.gemfile)
  end
end
