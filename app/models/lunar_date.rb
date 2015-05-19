class LunarDate < ActiveRecord::Base
  def self.today
    today = Date.today.strftime "%Y%m%d"

    lunar_date = LunarDate.find_by_date(today) || LunarDate.new
    lunar_date
  end

  def self.today_data
    data = <<DATA
BEGIN:VCALENDAR
PRODID:-//153.121.51.69//农历//
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:PUBLISH
X-WR-TIMEZONE:Asia/Shanghai
X-WR-CALNAME:今日农历
X-WR-CALDESC:今日农历
#{self.today.data}
END:VCALENDAR
DATA
    data.strip!

    return data
  end

  def data
    data = <<DATA
BEGIN:VEVENT
DTSTART;VALUE=DATE:#{self.date}
DTEND;VALUE=DATE:#{self.date}
DTSTAMP:#{self.date}T160000Z
UID:lunar_date_#{self.date}
CLASS:PUBLIC
DESCRIPTION:农历日历
LAST-MODIFIED:#{self.date}T165920Z
SEQUENCE:1
STATUS:CONFIRMED
SUMMARY:#{self.summary}
TRANSP:OPAQUE
END:VEVENT
DATA
    data.strip!

    return data
  end
end
