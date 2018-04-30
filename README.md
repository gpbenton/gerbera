# gerbera
Docker installation of [gerbera](https://github.com/gerbera/gerbera), a upnp media server

# Usage
 - git clone https://github.com/gpbenton/gerbera.git
 - cd gerbera
- docker-compose build

- mkdir config
- chmod 777 config
- edit volume lines in docker-compose.yaml to point to your media
- docker-compose up
- Stop docker
- Edit config/config.xml and add the following to the `import` section
```
    <autoscan>
        <directory location="/media" mode="timed" interval="3600"
  level="full" recursive="yes" hidden-files="no"/>
    </autoscan>
```
- docker-compose up -d
