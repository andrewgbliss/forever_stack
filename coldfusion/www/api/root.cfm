<cfscript>
response = {
    "message": "ColdFusion API is running!",
    "status": "ok",
    "timestamp": dateDiff("s", createDate(1970, 1, 1), now()),
    "service": "coldfusion"
};

writeOutput(serializeJSON(response));
</cfscript>
