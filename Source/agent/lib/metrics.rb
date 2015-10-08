
def cpu_usage
  (`w | head -n1`).split(' ')[-3]
end

def number_of_cores
  number_of_cores = (`sysctl -n hw.ncpu`).to_i
end

def disk_usage
  disk_usage = (`df -h / | tail -n1`).split(' ')[3]
end

def process_running
  ((`ps ax | wc -l`).to_i - 1)
end

def total_disk
  (`df -h / | tail -n1`).split(' ')[2]
end


def stats

  { :cpu_usage        => cpu_usage, 
    :disk_usage       => disk_usage, 
    :process_runing   => process_running,
    :number_of_cores  => number_of_cores,
    :total_disk       => total_disk
  }

end
