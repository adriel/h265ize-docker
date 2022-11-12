# h265ize

A [Docker](http://docker.com) image for [h265ize](https://github.com/FallingSnow/h265ize), to make it easy to convert videos to h.265.

## Getting Started

```sh
docker run -d --init \
  --name h265ize \
  -u <UID> \
  --restart unless-stopped \
  -v </location/to/video/files/input>:/input \
  -v </location/to/video/files/output>:/output \
  adriel/h265ize
```

Replace `<UID>` with your user's ID, you can get this by running `id -u`, e.g. `-u 1002 `.

This is to make sure the container can read/write your input and output directories.

#### How does it work?

Once your container is up and running move or copy a video to your input directory and h265ize will automatically start converting it to h.265 as per your settings. It **won't** convert any files already in the input folder when the docker container is started, only **new/added** files.

A file will appear straight away in the output directory while it's **still** being converted, please wait for it to finish converting before moving it out, or else you'll have a half converted file. In a [future update to h265ize](https://github.com/FallingSnow/h265ize/issues/77) it will append, `.h265tmp` to the end of a file while it's being converted. 

## Optional parameters

You can add your own parameters.

#### Set quality

For example, you may want to change the default quality from 19 to 25 (higher number = lower quality/smaller file)

```sh
docker run -d --init \
  --name h265ize \
  -u <UID> \
  --restart unless-stopped \
  -v /location/to/video/files/input:/input \
  -v /location/to/video/files/output:/output \
  adriel/h265ize -q 25
```
Note the `-q 25` added after `adriel/h265ize`.

You can add any of the options mentioned on the [official h265ize GitHub page](https://github.com/FallingSnow/h265ize#options) after the image name.

#### Paths in container

Directory where video files are you want to convert to h.265: `/input`

Directory where converted h.265 videos will be created: `/output`

## Production use

It's [recommended](https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md) to add the NODE_ENV environment variable and Node.js memory limits.

```sh
docker run -d --init \
  --name h265ize \
  -e "NODE_ENV=production" \
  -u <UID> \
  -m "300M" --memory-swap "1G" \
  --restart unless-stopped \
  -v /home/yo/dockers/h265ize/docker_files/input:/input \
  -v /home/yo/dockers/h265ize/docker_files/output:/output \
  adriel/h265ize
```

### Info - program versions

[h265ize](https://github.com/FallingSnow/h265ize) - latest code on the master branch as the latest NPM version doesn't support the `--watch` option.

[Node.js ]([https://hub.docker.com/_/node/) - latest version, 7.8.0.

##### Shell access

```sh
docker exec -it h265ize /bin/sh
```

##### Logs

```sh
docker logs -f h265ize
```

#### Change log
12/11/2022 - Updated to node v19
11/04/2017 - initial build.

----

Please feel free to leave a comment if you have any questions.
