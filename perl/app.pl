#!/usr/bin/env perl

use Dancer2;
use DBI;
use JSON;

# Database connection
my $dbh = DBI->connect(
    $ENV{DATABASE_URL} || "dbi:Pg:dbname=postgres;host=postgres;port=5432",
    $ENV{POSTGRES_USER} || "postgres",
    $ENV{POSTGRES_PASSWORD} || "postgres",
    { RaiseError => 1, AutoCommit => 1 }
);

# Routes
get '/' => sub {
    return { message => "Perl API is running!", status => "ok" };
};

get '/health' => sub {
    return { status => "healthy", service => "perl" };
};

get '/users' => sub {
    my $sth = $dbh->prepare("SELECT * FROM users LIMIT 10");
    $sth->execute();
    my $users = $sth->fetchall_arrayref({});
    return { users => $users };
};

post '/users' => sub {
    my $data = from_json(request->body);
    my $name = $data->{name};
    my $email = $data->{email};
    
    my $sth = $dbh->prepare("INSERT INTO users (name, email) VALUES (?, ?)");
    $sth->execute($name, $email);
    
    return { message => "User created successfully", id => $dbh->last_insert_id };
};

# Start the application
dance;
