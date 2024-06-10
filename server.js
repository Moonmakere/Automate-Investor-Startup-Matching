const express = require('express');
const bodyParser = require('body-parser');
const sql = require('mssql');
const path = require('path');
const app = express();
const port = 3000;

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

// Function to create the table if it doesn't exist
const createTableIfNotExists = async function() {
    try {
        await sql.connect(config);
        const tableCreationQuery = `
            IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Registrations' AND xtype='U')
            CREATE TABLE Registrations (
                id INT IDENTITY(1,1) PRIMARY KEY,
                name NVARCHAR(100) NOT NULL,
                startupname NVARCHAR(100) NOT NULL,
                email NVARCHAR(100) NOT NULL,
                regions_countries NVARCHAR(100) NOT NULL,
                startupstage NVARCHAR(100) NOT NULL,
                industry NVARCHAR(100) NOT NULL,
                registration_date DATETIME DEFAULT GETDATE()
            );
        `;
        await sql.query(tableCreationQuery);
        console.log('Table created or already exists.');
    } catch (err) {
        console.error('Error creating table:', err);
    }
};

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'Register')));

// Middleware to parse request bodies
app.use(bodyParser.json());

// Define a route handler for the root path
app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname,'Register','Register.html'));
});

// Endpoint to handle form submission
app.post('/register', async function(req, res) {
    const { name, startupname, email, regions_countries, startupstage, industry } = req.body;

    try {
        // Connect to Azure SQL Database
        await sql.connect(config);
        
        // Insert data into database
        const result = await sql.query`INSERT INTO Registrations (name, startupname, email, regions_countries, startupstage, industry) VALUES (${name}, ${startupname},  ${email}, ${regions_countries}, ${startupstage}, ${industry})`;

        res.json({ message: 'Registration successful', result });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Registation failed', error: err.message });
    }
});

// Start the server
app.listen(port, function() {
    console.log(`Server running at http://localhost:${port}`);
});
