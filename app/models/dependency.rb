class Dependency
  include Mongoid::Document
  include Mongoid::Timestamps

  field :kind, type: String
  field :name, type: String
  field :requirement, type: String
  field :source, type: String
  field :groups, type: Array

  belongs_to :scan

  def self.create_from_gemfile(gemfile)
    Gemnasium::Parser.gemfile(gemfile).dependencies.map do |dependency|
      self.create(groups: dependency.groups, source: dependency.source, kind: dependency.type, name: dependency.name, requirement: dependency.requirement)
    end
  end
end
