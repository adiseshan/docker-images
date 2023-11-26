# docker-images

This repository contains dockerfiles and image-copy configuration.

## How to add a new Dockerfile

To add a new Dockerfile, make a new directory with `mkdir -p ${IMAGE_NAME}/${IMAGE_TAG}` then put the new Dockerfile into the directory.

## How to add a copy of a public docker image

To add a copy of a public docker image, make a new directory with `mkdir -p ${IMAGE_NAME}/${IMAGE_TAG}` then put a `copy_image.json` with below example content

copy_image.json:

``` json
{
  "from": "FROM_PUBLIC_DOCKER_IMAGE",
  "to": "TO_PRIVATE_DOCKER_IMAGE"
}
```

See [node-exporter/v1.3.1/copy_image.json](node-exporter/v1.3.1/copy_image.json) for example. Be sure that the `to` value is prefixed by `adiseshan/`.
