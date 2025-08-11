component {
    this.name = "ForeverStackColdFusion";
    this.applicationTimeout = createTimeSpan(0, 2, 0, 0);
    this.sessionManagement = false;
    this.datasource = "";
    this.mappings = {};
    
    // Application variables
    variables.appStartTime = now();
    variables.serviceName = "ColdFusion API";
    variables.version = "1.0.0";
    
    public boolean function onApplicationStart() {
        writeLog("ColdFusion backend starting up...", "information");
        return true;
    }
    
    public void function onApplicationEnd(struct applicationScope) {
        writeLog("ColdFusion backend shutting down...", "information");
    }
    
    public boolean function onRequestStart(string targetPage) {
        // Set response type to JSON for API endpoints
        if (findNoCase("/api/", arguments.targetPage) || arguments.targetPage == "/") {
            getPageContext().getResponse().setContentType("application/json");
        }
        return true;
    }
}
