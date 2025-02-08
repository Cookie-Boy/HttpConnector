%dw 2.0

fun extractSchemaName(uri: String, path: String): String =
	"[api-object] " ++ (uri replace (path ++ '/') with '')

fun createSchemaQuery(schemaName: String): String = 
	"CREATE SCHEMA " ++ "\"" ++ schemaName ++ "\";"
	
fun generateTableNames(currentYear: Number, currentQuarter: Number): Array<String> =
 	[ 
	    "messages_" ++ (if (currentQuarter == 1) (currentYear - 1) else currentYear) ++ "_" ++ (if (currentQuarter == 1) "4" else (currentQuarter - 1) as String),
	    "messages_" ++ currentYear ++ "_" ++ currentQuarter,
	    "messages_" ++ (if (currentQuarter == 4) (currentYear + 1) else currentYear) ++ "_" ++ (if (currentQuarter == 4) "1" else (currentQuarter + 1) as String)
  	]

fun createTableQuery(schemaName: String, tableName: String): String = 
	"CREATE TABLE  " ++ "\"" ++ schemaName ++ "\"." ++ tableName ++ 
	" (" ++
	"order_in_batch INT NOT NULL, " ++
	"correlation_id UUID NOT NULL, " ++
	"creation_date_time TIMESTAMPTZ NOT NULL DEFAULT now(), " ++
	"source_message_id JSONB NOT NULL, " ++
	"source_message_object JSONB NOT NULL" ++
	");"
	
fun insertMessagesQuery(schemaName: String, tableName: String): String =
	"INSERT INTO " ++ "\"" ++ schemaName ++ "\"." ++ tableName ++ 
	" (order_in_batch, correlation_id, creation_date_time, source_message_id, source_message_object) " ++
	"VALUES " ++
	"(:order_in_batch::integer, :correlation_id::uuid, :creation_date_time::timestamp with time zone, :source_message_id::jsonb, :source_message_object::jsonb)"





