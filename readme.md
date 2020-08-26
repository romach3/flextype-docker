```shell script
docker build -t flextype --build-arg FLEXTYPE_SOURCE_URL="https://github.com/flextype/flextype/releases/download/v0.9.11/flextype-cms-0.9.11.zip" .
docker run --publish 8080:80 flextype
```

or

```shell script
docker-compose up -d
```
