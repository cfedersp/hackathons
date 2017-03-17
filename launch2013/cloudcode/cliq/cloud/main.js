require('cloud/app.js');

// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello Niggaz!");
});

Parse.Cloud.define("SummarizeActivityCounts", function(request, response) {
  var downForSums = new Object();
  var activityQuery = new Parse.Query("Activities");
  //activityQuery.equalTo("movie", request.params.movie);
  activityQuery.find({
    success: function(results) {
      
      for (var i = 0; i < results.length; ++i) {
        downForSums[results[i].get("name")] = 0;
      }
    },
    error: function() {
      response.error("Activities lookup failed");
    }
  });
  
  
  var statusQuery = new Parse.Query("PFUser");
  var requestedFriendIds = request.params.ids;
  if(requestedFriendIds != null) {
  	statusQuery.containedIn("fbUserId", requestedFriendIds);
  }
  statusQuery.find({
    success: function(statusQueryResults) {
      
      for (var i = 0; i < statusQueryResults.length; ++i) {
        var currentUsersDownForList = statusQueryResults[i].get("downFor");
        if(currentUsersDownForList != null) {
        	for (var q = 0; q < currentUsersDownForList.length; ++q) {
       			var lastCount = downForSums[currentUsersDownForList[q]];
       			if(lastCount == null) {
       				lastCount = 0;
       			}
       			++lastCount;
       			downForSums[currentUsersDownForList[q]] = lastCount;
      		}
      	}
      }
      response.success(downForSums);
    },
    error: function() {
      response.error("UserStatus lookup failed");
    }
  });
  
});