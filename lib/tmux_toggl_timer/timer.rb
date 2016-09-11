require 'time'

module TmuxTogglTimer
  class Timer
    def initialize(fetcher, workspace_id)
      @fetcher = fetcher
      @workspace_id = workspace_id
      @time_format = '%H:%M'
    end

    def output
      current = @fetcher.current_entry_data
      total = @fetcher.total_time_miliseconds(@workspace_id)
      return '' if !current && !total
      "#{current_entry_output(current)} (#{total_str(total, current)})"
    end

    def current_time
      Time.now.to_i
    end

    private

    def current_entry_output(current_entry_data)
      return '-:-' unless current_entry_data

      current_duration = duration(current_entry_data['duration'])
      current_time = format_time(current_duration)
      project_name = @fetcher.project_name(current_entry_data['pid'])
      "[#{project_name}] #{current_time}"
    end

    def total_str(total, current)
      current_duration = current ? duration(current['duration']) : 0
      miliseconds = total ? total / 1000 + current_duration : current_duration.abs
      format_time(miliseconds)
    end

    def duration(miliseconds_passed)
      current_time + miliseconds_passed
    end

    def format_time(miliseconds)
      Time.at(miliseconds).utc.strftime(@time_format)
    end
  end
end
