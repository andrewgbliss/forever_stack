<cfscript>
response = {
    "status": "healthy",
    "service": "coldfusion",
    "uptime": dateDiff("s", createDate(1970, 1, 1), now())
};

writeOutput(serializeJSON(response));
</cfscript>
