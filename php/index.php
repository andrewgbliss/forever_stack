<?php
require 'vendor/autoload.php';

use Slim\Factory\AppFactory;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

$app = AppFactory::create();

// Set base path for /php/ prefix
$app->setBasePath('/php');

// Add error middleware
$app->addErrorMiddleware(true, true, true);

// Routes
$app->get('/', function (Request $request, Response $response) {
    $data = [
        'message' => 'PHP API is running!', 
        'status' => 'ok',
        'timestamp' => time(),
        'service' => 'php-basic'
    ];
    $response->getBody()->write(json_encode($data, JSON_PRETTY_PRINT));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/health', function (Request $request, Response $response) {
    $data = [
        'status' => 'healthy', 
        'service' => 'php',
        'uptime' => time()
    ];
    $response->getBody()->write(json_encode($data, JSON_PRETTY_PRINT));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/info', function (Request $request, Response $response) {
    $data = [
        'service' => 'PHP Basic API',
        'version' => '1.0.0',
        'description' => 'A simple PHP web application without database',
        'endpoints' => ['/', '/health', '/info', '/echo', '/math/add', '/math/multiply', '/data'],
        'modules' => 'Slim Framework only'
    ];
    $response->getBody()->write(json_encode($data, JSON_PRETTY_PRINT));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/echo', function (Request $request, Response $response) {
    $queryParams = $request->getQueryParams();
    $message = $queryParams['message'] ?? 'Hello World!';
    
    $data = [
        'echo' => $message,
        'timestamp' => time()
    ];
    $response->getBody()->write(json_encode($data, JSON_PRETTY_PRINT));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/math/add', function (Request $request, Response $response) {
    $queryParams = $request->getQueryParams();
    $a = (int)($queryParams['a'] ?? 0);
    $b = (int)($queryParams['b'] ?? 0);
    
    $data = [
        'operation' => 'addition',
        'a' => $a,
        'b' => $b,
        'result' => $a + $b
    ];
    $response->getBody()->write(json_encode($data, JSON_PRETTY_PRINT));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/math/multiply', function (Request $request, Response $response) {
    $queryParams = $request->getQueryParams();
    $a = (int)($queryParams['a'] ?? 1);
    $b = (int)($queryParams['b'] ?? 1);
    
    $data = [
        'operation' => 'multiplication',
        'a' => $a,
        'b' => $b,
        'result' => $a * $b
    ];
    $response->getBody()->write(json_encode($data, JSON_PRETTY_PRINT));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->post('/data', function (Request $request, Response $response) {
    $data = $request->getParsedBody();
    
    $result = [
        'received' => $data,
        'processed' => time(),
        'message' => 'Data received successfully'
    ];
    $response->getBody()->write(json_encode($result, JSON_PRETTY_PRINT));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->run();
