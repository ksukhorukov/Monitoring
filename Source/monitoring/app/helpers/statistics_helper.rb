module StatisticsHelper

  def skip_gigs(size)
    size.chop.chop.to_f
  end

  def get_max_disk(servers)
    max = 0
    server_id = 0
    servers.each do |server|
      if skip_gigs(server.statistics.maximum(:disk_usage)) > max
        max = skip_gigs(server.statistics.maximum(:disk_usage))
        server_id = server.id
      end
    end
    Server.find(server_id)
  end

  def get_max_cpu(servers)
    max = 0.0
    server_id = 0
    servers.each do |server|
      if server.statistics.maximum(:cpu_usage).to_f > max
        max = server.statistics.maximum(:cpu_usage).to_f
        server_id = server.id
      end
    end
    Server.find(server_id)
  end

  def get_max_procs(servers)
    max = 0
    server_id = 0
    servers.each do |server|
      if server.statistics.maximum(:process_running) > max
        max = server.statistics.maximum(:process_running)
        server_id = server.id
      end
    end
    Server.find(server_id)
  end

  def runing_out_of_disk_space(used, available)
    puts "Input: #{used}, #{available}"
    if used.to_f / available.to_f > 0.9
      puts "Result: #{available.to_f / used.to_f}"
      true
    else
      false
    end
  end

  def high_cpu_usage(cpu, number_of_cores)
    puts "Input: #{cpu}, #{number_of_cores}"
    if cpu.to_f / number_of_cores.to_f > 0.9
      puts "high_cpu_usage: #{cpu / number_of_cores.to_f }"
      true
    else
      false
    end
  end

end
