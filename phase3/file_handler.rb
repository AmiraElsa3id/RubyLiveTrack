require_relative 'handler'

class FileHandler < Handler
  LOG_PATH = File.expand_path('../events.log', __FILE__)

  def handle(event)
    timestamp = event.timestamp.strftime("%Y-%m-%d %H:%M")
    line = "[#{timestamp}] #{event.type.upcase} — #{event.description} (#{event.duration} min)"
    File.open(LOG_PATH, 'a') { |f| f.puts(line) }
  end
end
