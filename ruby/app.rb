require 'sinatra'
require 'sinatra/json'
require 'pg'
require 'json'

# Database connection
def get_db
  host = 'postgres'
  dbname = ENV['POSTGRES_DB'] || 'postgres'
  user = ENV['POSTGRES_USER'] || 'postgres'
  password = ENV['POSTGRES_PASSWORD'] || 'postgres'
  
  PG.connect(host: host, dbname: dbname, user: user, password: password)
rescue => e
  puts "Database connection failed: #{e.message}"
  nil
end

# Routes
get '/' do
  json message: 'Ruby API is running!', status: 'ok'
end

get '/health' do
  json status: 'healthy', service: 'ruby'
end

get '/users' do
  db = get_db
  if db.nil?
    status 500
    json error: 'Database not connected'
  else
    begin
      result = db.exec('SELECT id, name, email FROM users LIMIT 10')
      users = result.map { |row| { id: row['id'], name: row['name'], email: row['email'] } }
      json users: users
    rescue => e
      status 500
      json error: e.message
    ensure
      db.close if db
    end
  end
end

post '/users' do
  db = get_db
  if db.nil?
    status 500
    json error: 'Database not connected'
  else
    begin
      data = JSON.parse(request.body.read)
      name = data['name']
      email = data['email']
      
      result = db.exec_params('INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id', [name, email])
      user_id = result[0]['id']
      
      json message: 'User created successfully', id: user_id
    rescue => e
      status 500
      json error: e.message
    ensure
      db.close if db
    end
  end
end
