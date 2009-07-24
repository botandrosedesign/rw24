module LapsHelper
  def lap_time(start, finish)
    start = start ? start.created_at : Time.parse("2009-07-24 17:00")
    finish = finish.created_at
    to_hours(finish - start)
  end

  def to_hours(seconds)
    hours = (seconds/60/60).floor
    minutes = ((seconds - (hours * 3600))/60).floor
    seconds = (seconds - (hours * 3600) - (minutes * 60)).round

    # add leading zero to one-digit minute
    if minutes < 10
      minutes = "0#{minutes}"
    end
    # add leading zero to one-digit second
    if seconds < 10
      seconds = "0#{seconds}"
    end
    # return formatted time
    return "#{hours}:#{minutes}:#{seconds}"
  end
end
