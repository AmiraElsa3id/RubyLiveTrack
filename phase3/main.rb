require_relative 'event'
require_relative 'event_router'
require_relative 'console_handler'
require_relative 'file_handler'
require_relative 'stats_handler'

MENU = {
  1 => :WORK,
  2 => :STUDY,
  3 => :EXERCISE,
  4 => :MEAL
}.freeze

router = EventRouter.new
router.register(ConsoleHandler.new)
router.register(FileHandler.new)
router.register(StatsHandler.new)

puts "=== LifeTrack ==="

loop do
  puts
  puts "1. Log a work session"
  puts "2. Log a study session"
  puts "3. Log an exercise session"
  puts "4. Log a meal"
  puts "5. Exit"
  puts
  print "Choose an option: "

  choice = gets.chomp.to_i

  break if choice == 5

  type = MENU[choice]
  unless type
    puts "Invalid option. Please choose 1–5."
    next
  end

  print "Description: "
  description = gets.chomp

  print "Duration (minutes): "
  duration = gets.chomp.to_i

  puts
  event = Event.new(type, description, duration, Time.now)
  router.dispatch(event)
end
