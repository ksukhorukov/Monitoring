class Server < ActiveRecord::Base
  has_many :statistics, dependent: :delete_all
  validates :name, :api_key, :description, presence: true
  validates :name, :api_key, uniqueness: true

  def disk
    self.statistics.last.disk_usage
  end

  def cpu
    self.statistics.last.cpu_usage
  end

  def procs
    self.statistics.last.process_running
  end

  def disk_max
    self.statistics.maximum(:disk_usage)
  end

  def cpu_max
    self.statistics.maximum(:cpu_usage)
  end

  def procs_max
    self.statistics.maximum(:process_running)
  end

end
