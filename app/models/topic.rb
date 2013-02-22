class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :like, :unlike, :timeint

  ## add_timeint 用于将传进来的timeint加1，且考虑时间问题
  def self.add_timeint(timeint)
  	if timeint.to_s[8..9].to_i + 1 > 19
      time =  Time.local(timeint.to_s[0..3], timeint.to_s[4..5], timeint.to_s[6..7]).tomorrow
      timeint = time.year.to_s + time.month.to_s + time.day.to_s + "07"
    else
      timeint = timeint.to_s[0..7] + sprintf("%02i", timeint.to_s[8..9].to_i + 1)
    end
  end

  ## make_timeint 用于生成当前时间的timeint串
  def self.make_timeint
    time = Time.now
    if (time.hour - 6) > 12
      time = time.tomorrow
      timeint = time.year.to_s + time.month.to_s + time.day.to_s + "07"
    else
      timeint = time.year.to_s + time.month.to_s + time.day.to_s + (time.hour - 6).to_s
    end
  end
  
  ## del_timeint 用于将传进来的timeint减1，且考虑时间问题
  def self.del_timeint(timeint)
    if timeint.to_s[8..9].to_i - 7 <= 0
      time =  Time.local(timeint.to_s[0..3], timeint.to_s[4..5], timeint.to_s[6..7]).yesterday
      timeint = time.year.to_s + time.month.to_s + time.day.to_s + "19"
    else
      timeint = timeint.to_s[0..7] + sprintf("%02i", timeint.to_s[8..9].to_i - 1)
    end
  end
end
