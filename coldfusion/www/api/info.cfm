<cfscript>
response = {
    "service": "ColdFusion API",
    "version": "1.0.0",
    "description": "A simple ColdFusion web application without database",
    "endpoints": ["/", "/health", "/info", "/echo", "/math/add", "/math/multiply", "/data"],
    "modules": "ColdFusion only"
};

writeOutput(serializeJSON(response));
</cfscript>
