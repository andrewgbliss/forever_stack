<cfscript>
// Get parameters with defaults
a = val(url.a ?: 1);
b = val(url.b ?: 1);

response = {
    "operation": "multiplication",
    "a": a,
    "b": b,
    "result": a * b
};

writeOutput(serializeJSON(response));
</cfscript>
