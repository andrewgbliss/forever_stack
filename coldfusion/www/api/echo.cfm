<cfscript>
// Get the message parameter, default to "Hello World!"
message = url.message ?: "Hello World!";

response = {
    "echo": message,
    "timestamp": dateDiff("s", createDate(1970, 1, 1), now())
};

writeOutput(serializeJSON(response));
</cfscript>
