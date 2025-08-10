<?php
require 'vendor/autoload.php';

use Slim\Factory\AppFactory;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

$app = AppFactory::create();

// Database connection
function getDb() {
    $host = 'postgres';
    $dbname = $_ENV['POSTGRES_DB'] ?? 'postgres';
    $user = $_ENV['POSTGRES_USER'] ?? 'postgres';
    $pass = $_ENV['POSTGRES_PASSWORD'] ?? 'postgres';
    
    return new PDO("pgsql:host=$host;dbname=$dbname", $user, $pass);
}

// Routes
$app->get('/', function (Request $request, Response $response) {
    $data = ['message' => 'PHP API is running!', 'status' => 'ok'];
    $response->getBody()->write(json_encode($data));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/health', function (Request $request, Response $response) {
    $data = ['status' => 'healthy', 'service' => 'php'];
    $response->getBody()->write(json_encode($data));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/users', function (Request $request, Response $response) {
    $db = getDb();
    $stmt = $db->query('SELECT * FROM users LIMIT 10');
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $response->getBody()->write(json_encode(['users' => $users]));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->post('/users', function (Request $request, Response $response) {
    $data = $request->getParsedBody();
    $name = $data['name'] ?? '';
    $email = $data['email'] ?? '';
    
    $db = getDb();
    $stmt = $db->prepare('INSERT INTO users (name, email) VALUES (?, ?)');
    $stmt->execute([$name, $email]);
    
    $result = ['message' => 'User created successfully', 'id' => $db->lastInsertId()];
    $response->getBody()->write(json_encode($result));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->run();
