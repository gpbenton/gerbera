This project is archived as the official docker image is now smaller than this image

# gerbera
Docker installation of [gerbera](https://github.com/gerbera/gerbera), a upnp media server

# Usage
Either | Or
-------|---
git clone https://github.com/gpbenton/gerbera.git | docker pull gpbenton/gerbera
cd gerbera                                        | mkdir gerbera
docker-compose build                              | cd gerbera

- mkdir config
- chmod 777 config
- edit volume lines in docker-compose.yaml to point to your media
- docker run -it --rm gerbera_app --create-config > config/config.xml  # this generates the configuration file for gerbera
- docker-compose up
- Stop docker
- Edit config/config.xml and add the following to the `import` section
```
    <autoscan>
        <directory location="/media" mode="timed" interval="3600"
  level="full" recursive="yes" hidden-files="no"/>
    </autoscan>
```
Remove the top text before the config section and then add this line to the top
```
<?xml version="1.0" encoding="UTF-8"?>
```
- docker-compose up -d
