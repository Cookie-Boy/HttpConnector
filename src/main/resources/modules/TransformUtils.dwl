%dw 2.0

fun transformMessages(messages: Array<Object>, batchSize: Number): Array<Object> =
	messages map ((item, index) -> 
		{
			order_in_batch: (floor(index / batchSize)) + 1,
			correlation_id: uuid(),
	      	creation_date_time: now() as String {format: "yyyy-MM-dd HH:mm:ssXXX"},
	      	source_message_id: item.id,
	      	source_message_object: item.object
		}
	)
	
fun splitMessages(processedData: Array<Object>): Array<Array<Object>> =
	processedData 
		groupBy ((item, index) -> item.order_in_batch)
		pluck ((value, key, index) -> value)
		