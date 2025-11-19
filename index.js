const express = require('express');
const app = express();
const PORT = 4000;

app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from Node server!' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Node server running on port ${PORT}`);
});
