# docker-guis

Docker GUIs is my personal collection of docker containers I build for GUI applications I commonly use. Since the GUI images are based on linux you will need a **linux environment** in order to be able to use them, with the commands given (although there exists the possibility to run them on Windows with some X11 tooling, or via using VNC and a webserver within the docker image, I am not going into details here)

In general all containers by default assume a user with `UID 1000` and `GID 1000`. In order to adapt to different displays being used, even when reusing a container, all containers support injecting environment variables. During startup if it does not exist, the following file will be created `~/.env/template-<application>.sh` and `~/.env/environment.sh` will be loaded and executed before launching the actual application. So by mounting your actual home directory into the container you can control the environment variables without havin to recreate the container.

## alpine linux based containers

These are the applications, I currently got working with alpine linux, for minimal image size.

### freemind

[freemind](http://freemind.sourceforge.net/wiki/index.php/Main_Page) is my favorite mind mapping tool, simply because of the great keyboard shortcuts.

#### build

```bash
# build the image and tag it
docker build ./alpine/freemind/ -t seifrox/freemind:1.0.1
```

#### run

```bash
# running the container from the image and naming it, so it can be reused
docker run --name freemind-1.0.1 -e DISPLAY --net=host -v ~/:/home/user seifrox/freemind:1.0.1

# subsequent usage of the same container
docker start freemind-1.0.1
```

#### docker-compose

```bash
# running it (it will build it if necessary)
cd ./alpine/freemind/ && docker-compose up
```

## debian linux based containers

These are the applications, I currently was not able to get running with alpine without any issues.

### android studio

I use [android studio](https://developer.android.com/studio) for Android development, currently still with JDK 8

#### build

```bash
# build the image and tag it
docker build ./debian/android-studio/ -t seifrox/android-studio-3.4.2.0:openjdk-8
```

#### run

```bash
# running the container from the image and naming it, so it can be reused
docker run --name android-studio-3.4.2.0 -e DISPLAY --net=host -v /dev/bus/usb:/dev/bus/usb -v ~/data/code/android:/home/user/android-studio-workspace -v ~/.m2:/home/user/.m2 -v ~/.gradle:/home/user/.gradle -v ~/android-sdk:/home/user/Android/Sdk seifrox/android-studio-3.4.2.0:openjdk-8


# subsequent usage of the same container
docker start android-studio-3.4.2.0
```

#### docker-compose

```bash
# running it (it will build it if necessary)
cd ./debian/android-studio/ && docker-compose up
```

### eclipse

I use [eclipse](https://www.eclipse.org) for Java development, currently still with JDK 8, so this image contains the version I need plus my favourite plugins. For adapting to your own plugin needs, check out this [guide](https://stackoverflow.com/questions/47582157/eclipse-marketplace-plug-ins-silent-install)

#### build

```bash
# build the image and tag it
docker build ./debian/eclipse -t seifrox/eclipse-2019-06:openjdk-8
```

#### run

```bash
# running the container from the image and naming it, so it can be reused
docker run --name eclipse-2019-06-openjdk-8 --env DISPLAY --env NO_AT_BRIDGE=1 --add-host=$HOSTNAME:127.0.0.1 --net=host -v ~/data/code/java/:/home/user/workspace -v ~/.m2/:/home/user/.m2 -v ~/.env:/home/user/.env seifrox/eclipse-2019-06:openjdk-8

# subsequent usage of the same container
docker start eclipse-2019-06-openjdk-8
```

#### docker-compose

```bash
# running it (it will build it if necessary)
cd ./debian/eclipse/ && docker-compose up
```
