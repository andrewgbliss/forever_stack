#!/usr/bin/env perl

use strict;
use warnings;
use Socket;
use IO::Handle;
use JSON::PP;

# Configuration
my $port = 5000;
my $host = '0.0.0.0';

# Create socket
socket(my $server, PF_INET, SOCK_STREAM, getprotobyname('tcp')) or die "socket: $!";
setsockopt($server, SOL_SOCKET, SO_REUSEADDR, 1) or die "setsockopt: $!";
bind($server, sockaddr_in($port, inet_aton($host))) or die "bind: $!";
listen($server, SOMAXCONN) or die "listen: $!";

print "Perl Basic Server running on http://$host:$port\n";

# Main server loop
while (my $client = accept(my $client_socket, $server)) {
    handle_request($client_socket);
    close($client_socket);
}

sub handle_request {
    my ($client) = @_;
    
    # Read request
    my $request = '';
    while (my $line = <$client>) {
        $request .= $line;
        last if $line =~ /^\r?\n$/;
    }
    
    # Parse request line
    my ($method, $path, $version) = split(' ', $request);
    $path =~ s/\?.*$//; # Remove query string for now
    
    # Read body if POST
    my $body = '';
    if ($method eq 'POST') {
        while (my $line = <$client>) {
            $body .= $line;
        }
    }
    
    # Route request
    my $response = route_request($method, $path, $body);
    
    # Send response
    print $client $response;
}

sub route_request {
    my ($method, $path, $body) = @_;
    
    my $json = JSON::PP->new->utf8->pretty;
    
    if ($path eq '/' || $path eq '') {
        return create_response(200, $json->encode({
            message => "Perl API is running!",
            status => "ok",
            timestamp => time(),
            service => "perl-basic-core"
        }));
    }
    elsif ($path eq '/health') {
        return create_response(200, $json->encode({
            status => "healthy",
            service => "perl",
            uptime => time()
        }));
    }
    elsif ($path eq '/info') {
        return create_response(200, $json->encode({
            service => "Perl Basic API (Core Only)",
            version => "1.0.0",
            description => "A simple Perl web application using only core modules",
            endpoints => ["/", "/health", "/info", "/echo", "/math/add", "/math/multiply", "/data"],
            modules => "Core Perl only - no external dependencies"
        }));
    }
    elsif ($path eq '/echo') {
        my $message = "Hello World!";
        if ($body =~ /message=([^&\s]+)/) {
            $message = $1;
        }
        return create_response(200, $json->encode({
            echo => $message,
            timestamp => time()
        }));
    }
    elsif ($path eq '/math/add') {
        my ($a, $b) = (0, 0);
        if ($body =~ /a=(\d+)/) { $a = $1; }
        if ($body =~ /b=(\d+)/) { $b = $1; }
        
        return create_response(200, $json->encode({
            operation => "addition",
            a => $a,
            b => $b,
            result => $a + $b
        }));
    }
    elsif ($path eq '/math/multiply') {
        my ($a, $b) = (1, 1);
        if ($body =~ /a=(\d+)/) { $a = $1; }
        if ($body =~ /b=(\d+)/) { $b = $1; }
        
        return create_response(200, $json->encode({
            operation => "multiplication",
            a => $a,
            b => $b,
            result => $a * $b
        }));
    }
    elsif ($path eq '/data' && $method eq 'POST') {
        my $data = { received => "Data received", raw_body => $body };
        return create_response(200, $json->encode({
            received => $data,
            processed => time(),
            message => "Data received successfully"
        }));
    }
    else {
        return create_response(404, $json->encode({
            error => "Endpoint not found",
            path => $path,
            method => $method,
            available_endpoints => ["/", "/health", "/info", "/echo", "/math/add", "/math/multiply", "/data"]
        }));
    }
}

sub create_response {
    my ($status_code, $body) = @_;
    
    my $status_text = {
        200 => "OK",
        404 => "Not Found",
        500 => "Internal Server Error"
    }->{$status_code} || "Unknown";
    
    my $response = "HTTP/1.1 $status_code $status_text\r\n";
    $response .= "Content-Type: application/json\r\n";
    $response .= "Content-Length: " . length($body) . "\r\n";
    $response .= "Access-Control-Allow-Origin: *\r\n";
    $response .= "Connection: close\r\n";
    $response .= "\r\n";
    $response .= $body;
    
    return $response;
}
