// require express library 
const express = require('express');

// use the express library to create a new app 
const app = express();

// set up a route handler 
app.get('/', (req, res) => {
    res.send("I'm a server and you've got my response");
});

// set up our app to listen on a port 

app.listen(8080, () => {
    console.log('Listening on port 8080')
});