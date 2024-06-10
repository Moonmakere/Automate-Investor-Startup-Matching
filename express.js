const express = require('express');
const bodyParser = require('body-parser');
const sql = require('mssql');
const app = express();
const port = 3001;

// Configure Azure SQL Database connection
const config = {
  user: 'Mantasha', // Update with your Azure SQL username
  password: 'Saad8052595419', // Update with your Azure SQL password
  server: 'investor-startup-db-server.database.windows.net', // Update with your Azure SQL server name
  database: 'investr-startup-db', // Update with your database name
  options: {
    encrypt: true,
    enableArithAbort: true
  }
};

// Middleware to parse request bodies
app.use(bodyParser.json());
app.use(express.static(path.join(__diname, 'project')));

// Define a route handler for the root path
app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname,'proect','login.html'));
});

// Handle login request
app.post('/login', async function(req, res) {
  const { username, password } = req.body;

  try {
    await sql.connect(config);
    const result = await sql.query`SELECT * FROM Users WHERE username = ${username} AND password = ${password}`;
    
    if (result.recordset.length > 0) {
      res.json({ message: 'Login successful' });
    } else {
      res.status(401).json({ message: 'Invalid username or password' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Login failed', error: err.message });
  }
});

// Handle password reset request
app.post('/reset-password', async function(req, res) {
  const { email } = req.body;

  try {
    await sql.connect(config);
    const result = await sql.query`SELECT * FROM Users WHERE email = ${email}`;
    
    if (result.recordset.length > 0) {
      // Logic to send reset email (omitted for brevity)
      res.json({ message: 'Password reset link sent to your email' });
    } else {
      res.status(404).json({ message: 'Email not found' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Password reset failed', error: err.message });
  }
});

app.listen(port, function() {
  console.log(`Server running at http://localhost:${port}`);
});
