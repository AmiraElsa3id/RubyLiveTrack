require_relative 'handler'
require 'sqlite3'

class SqliteHandler < Handler
  DB_PATH = File.expand_path('../life_track.db', __FILE__)

  def initialize
    @db = SQLite3::Database.new(DB_PATH)
    @db.execute(<<~SQL)
      CREATE TABLE IF NOT EXISTS events (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        type        TEXT    NOT NULL,
        description TEXT    NOT NULL,
        duration    INTEGER NOT NULL,
        logged_at   TEXT    NOT NULL
      )
    SQL
  end

  def handle(event)
    @db.execute(
      'INSERT INTO events (type, description, duration, logged_at) VALUES (?, ?, ?, ?)',
      [event.type.to_s, event.description, event.duration, event.timestamp.iso8601]
    )
  end
end
