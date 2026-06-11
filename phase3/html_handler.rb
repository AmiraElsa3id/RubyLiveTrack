require_relative 'handler'

class HtmlHandler < Handler
  HTML_PATH = File.expand_path('../dashboard.html', __FILE__)

  def initialize
    @events = []
  end

  def handle(event)
    @events << event
    File.write(HTML_PATH, render)
  end

  private

  def render
    rows = @events.map do |e|
      type_css = e.type.to_s.downcase
      timestamp = e.timestamp.strftime('%Y-%m-%d %H:%M')
      <<~ROW
        <tr>
          <td>#{timestamp}</td>
          <td><span class="badge #{type_css}">#{e.type}</span></td>
          <td>#{e.description}</td>
          <td>#{e.duration} min</td>
        </tr>
      ROW
    end.join

    <<~HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>LifeTrack Dashboard</title>
        <style>
          body { font-family: sans-serif; max-width: 800px; margin: 40px auto; background: #f9f9f9; color: #222; }
          h1 { color: #333; }
          table { width: 100%; border-collapse: collapse; background: #fff; box-shadow: 0 1px 4px rgba(0,0,0,.1); }
          th { background: #333; color: #fff; padding: 10px 14px; text-align: left; }
          td { padding: 9px 14px; border-bottom: 1px solid #eee; }
          tr:last-child td { border-bottom: none; }
          .badge { display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: .8em; font-weight: bold; color: #fff; }
          .work     { background: #4f86c6; }
          .study    { background: #6abf69; }
          .exercise { background: #f0883e; }
          .meal     { background: #9c6ade; }
          .summary  { margin-top: 24px; display: flex; gap: 16px; }
          .card     { flex: 1; background: #fff; border-radius: 8px; padding: 16px; box-shadow: 0 1px 4px rgba(0,0,0,.1); text-align: center; }
          .card h3  { margin: 0 0 6px; font-size: .9em; color: #666; text-transform: uppercase; letter-spacing: .05em; }
          .card p   { margin: 0; font-size: 1.8em; font-weight: bold; }
        </style>
      </head>
      <body>
        <h1>LifeTrack Dashboard</h1>
        <p>Last updated: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}</p>

        <div class="summary">
          #{summary_cards}
        </div>

        <br>
        <table>
          <thead>
            <tr><th>Time</th><th>Type</th><th>Description</th><th>Duration</th></tr>
          </thead>
          <tbody>
            #{rows}
          </tbody>
        </table>
      </body>
      </html>
    HTML
  end

  def summary_cards
    totals = @events.group_by(&:type).transform_values { |evs| evs.sum(&:duration) }
    [
      ["Work",     :WORK,     "min"],
      ["Study",    :STUDY,    "min"],
      ["Exercise", :EXERCISE, "min"],
      ["Meals",    :MEAL,     "logged"]
    ].map do |label, type, unit|
      value = unit == "logged" ? @events.count { |e| e.type == type } : (totals[type] || 0)
      css = type.to_s.downcase
      <<~CARD
        <div class="card">
          <h3>#{label}</h3>
          <p class="#{css}">#{value} <small style="font-size:.5em">#{unit}</small></p>
        </div>
      CARD
    end.join
  end
end
