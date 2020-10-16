# miniserver

## Development

To run the server you just need to execute this command

```ruby
rackup -p 9292
```

Where `-p` is the port of your choice

## Stack

- Ruby 2.7.0
- Rack 2.2

## Results

Using [httpie](https://httpie.org/)


### Method not allowed
`http GET 'http://127.0.0.1:9292'`

```
HTTP/1.1 405 Method Not Allowed
Connection: Keep-Alive
Content-Length: 37
Content-Type: application/json
Date: Fri, 16 Oct 2020 03:55:01 GMT
Server: WEBrick/1.6.0 (Ruby/2.7.0/2019-12-25)

{
    "message": "HTTP Method not allowed"
}
```

### Not acceptable request
`http POST 'http://127.0.0.1:9292' Accept:"application/xml"`

```
HTTP/1.1 406 Not Acceptable
Connection: Keep-Alive
Content-Length: 28
Content-Type: application/json
Date: Fri, 16 Oct 2020 03:56:35 GMT
Server: WEBrick/1.6.0 (Ruby/2.7.0/2019-12-25)

{
    "message": "Not Acceptable"
}
```

### Bad request
`http POST 'http://127.0.0.1:9292' Accept:"application/json" Content-Type:"application/xml" name="michelada" email="hello@michelada.io"`

```
HTTP/1.1 400 Bad Request
Connection: Keep-Alive
Content-Length: 25
Content-Type: application/json
Date: Fri, 16 Oct 2020 03:57:40 GMT
Server: WEBrick/1.6.0 (Ruby/2.7.0/2019-12-25)

{
    "message": "Bad Request"
}
```

`http POST 'http://127.0.0.1:9292' Accept:"application/json" Content-Type:"application/json"`

```
HTTP/1.1 400 Bad Request
Connection: Keep-Alive
Content-Length: 25
Content-Type: application/json
Date: Fri, 16 Oct 2020 03:58:44 GMT
Server: WEBrick/1.6.0 (Ruby/2.7.0/2019-12-25)

{
    "message": "Bad Request"
}
```

### Error, missing or empty name or email
`http POST 'http://127.0.0.1:9292' Accept:"application/json" Content-Type:"application/json" name="michelada" emails="hello@michelada.io"`

```
HTTP/1.1 400 Bad Request
Connection: Keep-Alive
Content-Length: 51
Content-Type: application/json
Date: Fri, 16 Oct 2020 03:59:39 GMT
Server: WEBrick/1.6.0 (Ruby/2.7.0/2019-12-25)

{
    "message": "Error, missing or empty name or email"
}
```

### Successful
`http POST 'http://127.0.0.1:9292' Accept:"application/json" Content-Type:"application/json" name="michelada" email="hello@michelada.io"`

```
HTTP/1.1 200 OK
Connection: Keep-Alive
Content-Length: 32
Content-Type: application/json
Date: Fri, 16 Oct 2020 04:00:21 GMT
Server: WEBrick/1.6.0 (Ruby/2.7.0/2019-12-25)

{
    "message": "Successful request"
}
```

`http POST 'http://127.0.0.1:9292' Accept:"application/json" Content-Type:"application/json" name="michelada" email="hello@michelada.io"`

```
HTTP/1.1 200 OK
Connection: Keep-Alive
Content-Length: 32
Content-Type: application/json
Date: Fri, 16 Oct 2020 04:00:52 GMT
Server: WEBrick/1.6.0 (Ruby/2.7.0/2019-12-25)

{
    "message": "Successful request"
}
```
