# docker-guis

Docker GUIs is my personal collection of docker containers I build for GUI applications I commonly use.

In general all containers by default assume a user with `UID 1000` and `GID 1000`. In order to adapt to different displays being used, even when reusing a container, all containers support injecting environment variables. During startup if it does not exist, the follwoing file will be created `~/.env/template-<application>.sh` and `~/.env/environment.sh` will be loaded and executed before launching the actual application. So by mounting your actual home directory into the container you can control the environment variables without havin to recreate the container.

## alpine linux based containers

These are the applications, I currently got working with alpine linux, for minimal image size.

### freemind

[freemind](http://freemind.sourceforge.net/wiki/index.php/Main_Page) is my favorite mind mapping tool, simply because of the great keyboard shortcuts.

## debian linux based containers

These are the applications, I currently was not able to get running with alpine without any issues.

### eclipse

I use [eclipse](https://www.eclipse.org) for Java development, so this image contains the version I need plus my favourite plugins. For adapting to your own plugin needs, check out this [guide](https://stackoverflow.com/questions/47582157/eclipse-marketplace-plug-ins-silent-install)
