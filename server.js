const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

// Add error handling
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

const server = app.listen(port, '0.0.0.0', () => {
    console.log(`Server running at http://localhost:${port}`);
    console.log(`Also try http://127.0.0.1:${port}`);
});

// Handle server errors
server.on('error', (error) => {
    if (error.code === 'EADDRINUSE') {
        console.error(`Port ${port} is already in use`);
    } else {
        console.error('Server error:', error);
    }
});

// Keep the process running
process.on('SIGINT', () => {
    server.close(() => {
        console.log('Server stopped gracefully');
        process.exit(0);
    });
}); 