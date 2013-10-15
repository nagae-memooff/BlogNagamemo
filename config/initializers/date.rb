class MDT
	def MDT.datetime
		Time.now.strftime('%Y-%m-%d %H:%M:%S')
	end
	def MDT.time
		Time.now.strftime('%H:%M:%S')
	end
	def MDT.date
		Time.now.strftime('%Y-%m-%d')
	end
end

