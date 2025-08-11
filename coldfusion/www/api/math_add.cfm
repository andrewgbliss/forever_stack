<cfscript>
// Get parameters with defaults
a = val(url.a ?: 0);
b = val(url.b ?: 0);

response = {
    "operation": "addition",
    "a": a,
    "b": b,
    "result": a + b
};

writeOutput(serializeJSON(response));
</cfscript>
