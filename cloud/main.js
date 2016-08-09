
Parse.Cloud.define('hello', function(req, res) {
  res.success('Hi');
});

// iOS push testing
Parse.Cloud.define('iosPushTest', function(request, response) {

// request has 2 parameters: params passed by the client and the authorized user
  var params = request.params;
  var user = request.user;

  // Our "Message" class has a "text" key with the body of the message itself
  var messageText = params.text;

  var pushQuery = new Parse.Query(Parse.Installation);
  pushQuery.equalTo('deviceType', 'ios'); // targeting iOS devices only

  Parse.Push.send({
    where: pushQuery, // Set our Installation query
    data: {
      alert: 'Message: ' + messageText
    }
  }, { success: function() {
    console.log('#### PUSH OK');
  }, error: function(error) {
    console.log('#### PUSH ERROR' + error.message);
  }, useMasterKey: true});

  response.success('success');
});

Parse.Cloud.define('currentPlayers', function(request, response) {
  var query = new Parse.Query('Quest');
  console.log('calling Current Players!!!');
  console.log(request.params.objectId);
  query.get();
  query.find({
    success: function(results) {
      var players = results[0].get('players');
      for (var i = 0; i < players.length; ++i) {
        myString += players[i];
      }
      console.log('Found a player?', myString);
      response.success(myString);
    },
    error: function() {
      response.error(' lookup failed' + results.length + results[0].get('players'));
    }
  });
});

Parse.Cloud.define('getPlayersNow', function(request, response){

  var Quest = Parse.Object.extend('Quest');
  var query = new Parse.Query(Quest);
  query.get(request.params.objectId, {
    success: function(gameScore) {
    // The object was retrieved successfully.
      console.log('found something', results);
      response.success('Got Something at Server');

    },
    error: function(object, error) {
    // The object was not retrieved successfully.
    // error is a Parse.Error with an error code and message.
      response.error('Quest lookup failed');
    }
  });
});

Parse.Cloud.define("averageStars", function(request, response) {
  var Quest = new Parse.Object.extend("Quest");
  var query = new Parse.Query(Quest);
  query.equalTo("objectId", request.params.objectId);
  query.find({
    success: function(results) {
      console.log('found something', results);
      var sum = 0;
      for (var i = 0; i < results.length; ++i) {
        sum += results[i].get("stars");
      }
      response.success(request.params.objectId.players);
    },
    error: function() {
      response.error("movie lookup failed");
    }
  });
});
