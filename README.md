# Super Simple Load Balancer

Super Simple Load Balancer is as the name say a super simple Load Balancer created to illustrate the basic features in any load balancer you might find out there.

It uses Round Robin Algorithm for backend selection with support for retries too.

It supports active and passive Health Checks as well as cleaning and recovery of backends.

Doesn't have anything fancy like https or weighted round-robin or least connections algorithms, maybe in the next iteration.

## How to use

```bash
Usage:
  -backends string
        Load balanced backends, use commas to separate
  -port int
        Port to serve (default 3030)
```
Example:

To add followings as load balanced backends
- http://localhost:3031
- http://localhost:3032
- http://localhost:3033
- http://localhost:3034
```bash
% super-simple-load-balancer --backends=http://localhost:3031,http://localhost:3032,http://localhost:3033,http://localhost:3034
```

### Or with Docker-Compose

What things you need to install the software and how to install them

```bash
% docker-compose up

Recreating load-balancer                   ... done
Creating supersimpleloadbalancer_server2_1 ... done
Creating supersimpleloadbalancer_server1_1 ... done
Creating supersimpleloadbalancer_server3_1 ... done
Attaching to supersimpleloadbalancer_server3_1, load-balancer, supersimpleloadbalancer_server2_1, supersimpleloadbalancer_server1_1
load-balancer   | 2020/08/01 15:35:53 Configured server: http://server1:80
load-balancer   | 2020/08/01 15:35:53 Configured server: http://server2:80
load-balancer   | 2020/08/01 15:35:53 Configured server: http://server3:80
load-balancer   | 2020/08/01 15:35:53 Load Balancer started at :3030
load-balancer   | 2020/08/01 15:36:13 Starting health check...
load-balancer   | 2020/08/01 15:36:13 http://server1:80 [up]
load-balancer   | 2020/08/01 15:36:13 http://server2:80 [up]
load-balancer   | 2020/08/01 15:36:13 http://server3:80 [up]
load-balancer   | 2020/08/01 15:36:13 Health check finished.
```

## Built With

* [Go](https://golang.org/) - go1.14
* Using only the Standard Library

## TODO
[ ] Add heap sort to help sort alive backends to reduce search surface

[ ] Monitoring and metrics

[ ] Add tests

[ ] Implement weighted round-robin and least connections algorithms

[ ] Support for configuration file

## Author

* **João Henrique Machado Silva** - [joaoh82](https://github.com/joaoh82)


## License

This project is licensed under the MIT License
