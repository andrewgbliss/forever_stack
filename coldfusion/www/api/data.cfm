<cfscript>
try {
    // Read the raw request body
    requestBody = toString(getHTTPRequestData().content);
    
    // Parse JSON data
    if (len(trim(requestBody)) > 0) {
        data = deserializeJSON(requestBody);
    } else {
        data = {};
    }
    
    response = {
        "received": data,
        "processed": dateDiff("s", createDate(1970, 1, 1), now()),
        "message": "Data received successfully"
    };
} catch (any e) {
    response = {
        "error": "Invalid JSON data",
        "message": e.message
    };
}

writeOutput(serializeJSON(response));
</cfscript>
