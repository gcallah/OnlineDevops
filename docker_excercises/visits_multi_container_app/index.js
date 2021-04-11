const express = require('express');
const redis = require('redis');
const process = require('process');
var crash = false;

// create a new instance of the express application 
const app = express();
// set up a connection to the Redis server 
const client = redis.createClient(({
    // we will be redirected to the container that is running our redis server 
    host: 'redis-server',
    port: 6379
}));
// initialize the visits variable on the Redis server 
client.set('visits', 0);

// add a route handler for the root route 
app.get('/', (req, res) => {
    // crash the server upon visit of the root route if crash flag is true 
    if (crash) {
        process.exit(0);
    }
    // get the current number of times that our page has been visited from the 
    // Redis server 
    // Note: visits is coming back as a String, not int
    client.get('visits', (err, visits) => {
        // send the number of visits to the client 
        res.send('Number of visits is ' + visits);
        // update the number of times the page has been visited on Redis 
        client.set('visits', parseInt(visits) + 1);
    });
});

// listen for incoming requests on port 8081
app.listen(8081, () => {
    console.log('Listening on port 4001');
});
