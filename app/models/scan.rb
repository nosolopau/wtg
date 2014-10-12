class Scan
  include Mongoid::Document
  include Mongoid::Timestamps

  pretends_like_state_machine states: [:waiting, :processing, :finished]

  field :gemfile, type: String
  field :dependencies_count, type: Integer

  validates :gemfile, presence: true

  has_many :dependencies

  def delay_process_dependencies!
    waiting!
    delay.process_dependencies!
  end

  def process_dependencies!
    processing!
    self.dependencies = Dependency.create_from_gemfile(dependencies_from_gemfile)
    finished!
  end

  def progress
    case state
      when :processing
        (dependencies.count * 100) / dependencies_count
      when :finished
        100
      else
        0
    end
  end

  def dependencies_count
    unless self[:dependencies_count]
      update_attribute(:dependencies_count, dependencies_from_gemfile.size)
    end

    self[:dependencies_count]
  end

  def dependencies_from_gemfile
    Gemnasium::Parser.gemfile(gemfile).dependencies
  end
end
