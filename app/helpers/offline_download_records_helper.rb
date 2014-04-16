module OfflineDownloadRecordsHelper
  UNITS = %w(B K M G T P E Z Y)

  def readable size
    cnt = 0
    loop do
      break if size <= 1023 && cnt < 8
      size /= 1024.0
      cnt += 1
    end
    puts size
    if 0 < size && size <= 9
      sprintf("%.1f%s", ((size*10.0).ceil)/10.0, UNITS[cnt])
    else
      sprintf("%i%s", size.ceil, UNITS[cnt])
    end
  end
end
