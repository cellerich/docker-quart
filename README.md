# docker-quart

* [GitHub](https://github.com/cellerich/docker-quart)  
* [Docker Hub](https://hub.docker.com/r/cellerich/docker-quart/)

You want to use Quart instead of Flask to be able to use the asynch functions. Here is the blueprint for a docker image to run a simple quart container to setup webservices

Original work was done by [Leafney](https://github.com/Leafney/docker-flask)

### Quart 

Quart is a Python web microframework based on Asyncio. It is intended to provide the easiest way to use asyncio in a web context, especially with exiting Flask apps. 

Quart is an evolution of the Flask API to work with Asyncio and to provide a number of features not present or possible in Flask. Compatibility with the Flask API is however the main aim, which means that the Flask documentation is an additional useful source of help.

- [Quart Documentation](https://pgjones.gitlab.io/quart/index.html)
- [Flask Documentation](http://flask.pocoo.org/docs/1.0/)
- [Quart on GitLab](https://gitlab.com/pgjones/quart)

### Alpine + Docker + Quart + Gunicorn + Supervisor

The image deploys Quart trough Gunicorn under the alpine system, and through Supervisor management as a background process.

Base image is `alpine:3.5`

#### Get image from Docker Hub

```
$ docker pull cellerich/docker-quart
```

#### Start a default background running container

```
$ docker run -it --name quart -d -p 5000:5000 cellerich/docker-quart
```

you can see it in browser by `http://your-host-ip:5000`.

***

##### Start a background container and mount a host directory to the container

Mounted under the host directory `/home/quartweb` into the container `/web`:

```
$ docker run --name quart -v /home/quartweb:/app -d -p 5000:5000 cellerich/docker-quart
```

Your host directory `quartweb` needs the following folder structure:

```
+ quartweb
  + conf
    - supervisor_flask.ini
  + logs
  + web
    - app.py
```

File `supervisor_flask.ini` is used to set the supervisor boot parameters and the Gunicorn settings.

Put your project file(s) in the `web` directory,`app.py` is the startup file for your Quart project. 

```python
from quart import Quart, websocket

app = Quart(__name__)

@app.route('/')
async def hello():
    return 'Hello World for Docker-quart with Python3.6 !'
```
And then through the command `$ docker restart quart` restart container.

Point your browser to `http://your-host-ip:5000`. and you will see
```
Hello World for Docker-quart with Python3.6 !
```


***

#### Installing additional quart or flask packages

We only installed the base dependency packages in the quart container. If you need other dependencies in your actual project, you can install dependencies in the running quart container with the following commands:

```
$ docker exec CONTAINER_ID/NAME /bin/sh -c "pip3 install package-name"
```

For example, to use the mongodb database, you can install the package with the following commands:

```
$ docker exec quart /bin/sh -c "pip3 install Flask-PyMongo"
```

After the installation is completed you need to restart the container `$ docker restart quart`.
