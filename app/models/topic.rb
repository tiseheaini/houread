class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :likeable, :timeint

  ## add_timeint 用于将传进来的timeint加1，且考虑时间问题
  def self.add_timeint(timeint)
    if timeint[8..9].to_i >= 5
      time =  Time.local(timeint[0..3], timeint[4..5], timeint[6..7]).tomorrow
      timeint = time.year.to_s + ("%02d" % time.month) + ("%02d" % time.day) + "00"
    else
      timeint = timeint[0..7] + sprintf("%02i", timeint[8..9].to_i + 1)
    end
  end

  ## current_timeint 用于生成当前时间的timeint串
  def self.current_timeint(time)
    case time.hour
      when 0..8
        timeint = time.year.to_s + ("%02d" % time.month.to_s) + ("%02d" % time.day.to_s) + "00"
      when 9..20
        timeint = time.year.to_s + ("%02d" % time.month.to_s) + ("%02d" % time.day.to_s) + ("%02d" % ((time.hour - 9)/2).to_s)
      when 21..23
        time = time.tomorrow
        timeint = time.year.to_s + ("%02d" % time.month.to_s) + ("%02d" % time.day.to_s) + "00"
    end
  end
  
  ## del_timeint 用于将传进来的timeint减1，且考虑时间问题
  def self.del_timeint(timeint)
    if timeint[8..9].to_i <= 0
      time =  Time.local(timeint[0..3], timeint[4..5], timeint[6..7]).yesterday
      timeint = time.year.to_s + ("%02d" % time.month) + ("%02d" % time.day) + "05"
    else
      timeint = timeint[0..7] + sprintf("%02i", timeint[8..9].to_i - 1)
    end
  end
end
