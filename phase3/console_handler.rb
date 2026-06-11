require_relative 'handler'

class ConsoleHandler < Handler
  def handle(event)
    timestamp = event.timestamp.strftime("%Y-%m-%d %H:%M")
    puts "[#{timestamp}] #{event.type.upcase} — #{event.description} (#{event.duration} min)"
    puts "✓ Event logged."
  end
end
