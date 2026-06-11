require_relative 'handler'

class StatsHandler < Handler
  def initialize
    @counts = Hash.new(0)
    at_exit { print_summary }
  end

  def handle(event)
    @counts[event.type] += 1
  end

  private

  def print_summary
    return if @counts.empty?
    puts
    puts "=== Session Summary ==="
    @counts.each { |type, count| puts "  #{type.upcase}: #{count} session#{count == 1 ? '' : 's'}" }
    puts "======================"
  end
end
