class Topic < ActiveRecord::Base
  attr_accessible :body, :like, :unlike, :timeint

  def self.addtimeint(timeint)
  	if timeint.to_s[8..9].to_i + 1 > 19
		  time =  Time.local(timeint.to_s[0..3], timeint.to_s[4..5], timeint.to_s[6..7]).tomorrow
			timeint = time.year.to_s + time.month.to_s + time.day.to_s + "07"
		else
		  timeint = timeint.to_s[0..7] + sprintf("%02i", timeint.to_s[8..9].to_i + 1)
		end
  end

	def self.maketimeint
		time = Time.now
		if (time.hour - 6) > 12
			time = time.tomorrow
			timeint = time.year.to_s + time.month.to_s + time.day.to_s + "07"
		else
		  timeint = time.year.to_s + time.month.to_s + time.day.to_s + time.hour - 6
		end
	end

	def self.deltimeint(timeint)
  	if timeint.to_s[8..9].to_i - 7 <= 0
		  time =  Time.local(timeint.to_s[0..3], timeint.to_s[4..5], timeint.to_s[6..7]).yesterday
			timeint = time.year.to_s + time.month.to_s + time.day.to_s + "19"
		else
		  timeint = timeint.to_s[0..7] + sprintf("%02i", timeint.to_s[8..9].to_i - 1)
		end
	end
end
