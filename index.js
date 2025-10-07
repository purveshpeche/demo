const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  console.log('INFO: / requested');
  res.send('Hello from sample-app');
});

app.get('/error', (req, res) => {
  console.error('ERROR: simulated error');
  res.status(500).send('simulated error');
});

app.listen(port, () => console.log(`Server listening on ${port}`));
