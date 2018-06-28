# saltapi-test

This is a simple docker setup for testing/experimenting with the saltstack
master API as found at https://docs.saltstack.com/en/latest/ref/netapi/all/salt.netapi.rest_cherrypy.html.

Usage instructions:

1. Build the Docker container: `docker build . -t {yourname}/saltapi-test:latest`
2. Run it: `docker run --rm -p 8000:80 {yourname}/saltapi-test:latest`
salt-master is started up in the background and salt-api in the foreground, you should
see the salt-api log being displayed in your terminal
3. You should now be able to access the salt api via port 8000 on your local machine:
  ```$ curl http://localhost:8000 -D-
  HTTP/1.1 200 OK
  Content-Length: 146
  Access-Control-Expose-Headers: GET, POST
  Vary: Accept-Encoding
  Server: CherryPy/unknown
  Allow: GET, HEAD, POST
  Access-Control-Allow-Credentials: true
  Date: Thu, 28 Jun 2018 09:32:53 GMT
  Access-Control-Allow-Origin: *
  Content-Type: application/json

  {"clients": ["local", "local_async", "local_batch", "local_subset", "runner", "runner_async", "ssh", "wheel", "wheel_async"], "return": "Welcome"}
  $
  ```
4. The container creates a user called `salttest` with the password `test` for default authentication, with full permissions.
This is simple to customise in the Dockerfile.
5. To shut the container down, use `docker container stop`:
  ```
  $ docker container ls
      CONTAINER ID        IMAGE                       COMMAND                  CREATED              STATUS              PORTS                  NAMES
    99b6d10d2ab2        andyg/saltapi-test:latest   "/bin/bash -c '/usr/…"   About a minute ago   Up About a minute   0.0.0.0:8000->80/tcp   dazzling_fermi
  $ docker container stop dazzling_fermi
  $ docker container rm dazzling_fermi
    ```
  (the last command is not necessary if you started the container with `--rm` on the `docker run` commandline)
