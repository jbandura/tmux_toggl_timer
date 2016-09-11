require 'tmux_toggl_timer/timer.rb'

describe Timer do
  let(:subject) do
    timer = Timer.new(fetcher_stub, 1)
    allow(timer).to receive(:current_time).and_return(146_567_940_5)
    timer
  end
  let(:fetcher_stub) { double('TogglFetcher') }

  context 'current task running' do
    it 'displays proper data when current task running' do
      allow(fetcher_stub).to receive_messages(
        current_entry_data: {
          'duration' => -146_567_799_8, # 23 minutes
          'pid' => 1
        },
        total_time_miliseconds: 290_160_00, # 8 hours 3 minutes
        project_name: 'foo'
      )
      output = subject.output
      expect(output).to eq('[foo] 00:23 (08:27)')
    end
  end

  context 'no current task running' do
    it 'displays proper data when total_time not nil' do
      allow(fetcher_stub).to receive_messages(
        current_entry_data: nil,
        total_time_miliseconds: 290_160_00, # 8 hours 3 minutes
        project_name: 'foo'
      )
      output = subject.output
      expect(output).to eq('-:- (08:03)')
    end

    it 'displays proper data when total_time nil' do
      allow(fetcher_stub).to receive_messages(
        current_entry_data: {
          'duration' => -146_567_799_8, # 23 minutes
          'pid' => 1
        },
        total_time_miliseconds: nil,
        project_name: 'foo'
      )
      expect(subject.output).to eq('[foo] 00:23 (00:23)')
    end
  end

  context 'no current and no total this day' do
    it 'displays correct data' do
      allow(fetcher_stub).to receive_messages(
        current_entry_data: nil,
        total_time_miliseconds: nil, # 8 hours 3 minutes
        project_name: 'foo'
      )
      output = subject.output
      expect(output).to eq('')
    end
  end
end
