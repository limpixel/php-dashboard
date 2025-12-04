<?php
// Database configuration for PHP Native Dashboard
// Supports both local development and Docker environments

// Check if running in Docker environment
if (getenv('DB_HOST')) {
    // Docker environment variables
    $dbhost = getenv('DB_HOST') ?: 'mysql';
    $dbusername = getenv('DB_USER') ?: 'root';
    $dbpassword = getenv('DB_PASS') ?: 'root_password';
    $dbname = getenv('DB_NAME') ?: 'stmik_ids';
} else {
    // Local development (MAMP/XAMPP)
    $dbhost = "localhost";
    $dbusername = "root";
    $dbpassword = "root";
    $dbname = "stmik_ids";
}

// Create database connection
$connection = mysqli_connect($dbhost, $dbusername, $dbpassword, $dbname);

// Check connection
if (!$connection) {
    die("Connection failed: " . mysqli_connect_error());
}
