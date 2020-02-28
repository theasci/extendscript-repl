// Bootstrap the host with app wide libraries and settings
'use strict';

// See https://estk.aenhancers.com/8%20-%20ExtendScript%20Tools%20and%20Features/dollar-object.html for built-in $ methods
$.strict = true;
var rootPath = new File($.fileName).parent
