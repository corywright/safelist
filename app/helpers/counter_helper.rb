#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

module CounterHelper
    attr :helper_interation_counters
	def set_counter(label, value)
		counter(label)
		@helper_interation_counters[label] = value
		return @helper_interation_counters[label]		
	end
	def zero_counter(label)
		set_counter label, 0
	end
	def counter(label)
        @helper_interation_counters ||= {}
		if @helper_interation_counters[label].nil? 
			@helper_interation_counters[label] = 0 
		end
		return @helper_interation_counters[label]	
	end
	def inc_counter(label)
		index = counter(label)
		@helper_interation_counters[label] = index + 1
		return @helper_interation_counters[label]
	end
	def row_style(label)
		inc_counter(label) %2 == 0 ?
			'evenrow' :
			'oddrow'
	end
	
end
