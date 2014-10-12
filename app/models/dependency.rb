class Dependency
  include Mongoid::Document
  include Mongoid::Timestamps

  field :kind, type: String
  field :name, type: String
  field :requirement, type: String
  field :source, type: String
  field :groups, type: Array

  field :info
  field :licenses
  field :project_uri
  field :current_version

  field :status

  belongs_to :scan

  def self.create_from_gemfile(dependency)
    new_dependency = self.create(groups: dependency.groups, source: dependency.source, kind: dependency.type, name: dependency.name, requirement: dependency.requirement)
    new_dependency.retrieve_and_set_details!
    new_dependency
  end

  def retrieve_and_set_details!
    gem_info = Gems.info(self.name)

    begin
      self.licenses = gem_info['licenses'].join(',')
    rescue
    end
    self.info = gem_info['info']
    self.current_version = gem_info['version']
    self.project_uri = gem_info['project_uri']

    self.save
  end
end
