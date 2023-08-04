Basic Dockerized ESCO Local API
===============================

This repository is a basic Docker-based setup to run the Local API of the [European Skills, Competences, and Occupations Classification (ESCO)](https://esco.ec.europa.eu/en).

Basic usage
-----------

Run:

```
docker-compose build
docker-compose up -d
```

Building the API image downloads the ESCO Local API, which is a large ZIP file of ca. 1.5GB and hence takes some time. As the unpacked ESCO database is included in the image, the image size is ca. 4.5GB.

The externally mapped port can be specified by setting the `PORT` variable in your `.env` file and defaults to `8080`.

Notice
------

This service uses the ESCO classification of the European Commission.

