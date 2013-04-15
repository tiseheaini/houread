class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :likeable, :timeint

  def self.rand_topic
    @topic = false
    begin
      last_id = Topic.last.id
      @topic = Topic.find(Random.rand(last_id))
    rescue
      @topic = Topic.send(:rand_topic)
    end
    @topic
  end

  ## encoding 用于在发微博时生成 base64加密字符串,并删掉串后面的 \n
  def self.encoding(timeint)
    rand_int = rand(100..999)
    encoding_str = (timeint.to_i * rand_int).to_s + rand_int.to_s
    Base64.encode64(encoding_str).chomp!
  end

  ## decoding 用于 topics#ending中解密生成查询字符串
  def self.decoding(encoding)
    decoding_str = Base64.decode64(encoding)
    (decoding_str[0..-4].to_i / decoding_str[-3..-1].to_i).to_s
  end

  ## add_timeint 用于将传进来的timeint加1，且考虑时间问题
  def self.add_timeint(timeint)
    timeint = timeint.to_s
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
      when 0..7
        timeint = time.year.to_s + ("%02d" % time.month.to_s) + ("%02d" % time.day.to_s) + "00"
      when 8..19
        timeint = time.year.to_s + ("%02d" % time.month.to_s) + ("%02d" % time.day.to_s) + ("%02d" % ((time.hour - 8)/2).to_s)
      when 20..23
        time = time.tomorrow
        timeint = time.year.to_s + ("%02d" % time.month.to_s) + ("%02d" % time.day.to_s) + "00"
    end
  end
  
  ## del_timeint 用于将传进来的timeint减1，且考虑时间问题
  def self.del_timeint(timeint)
    timeint = timeint.to_s
    if timeint[8..9].to_i <= 0
      time =  Time.local(timeint[0..3], timeint[4..5], timeint[6..7]).yesterday
      timeint = time.year.to_s + ("%02d" % time.month) + ("%02d" % time.day) + "05"
    else
      timeint = timeint[0..7] + sprintf("%02i", timeint[8..9].to_i - 1)
    end
  end
end
