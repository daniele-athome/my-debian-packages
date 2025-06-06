# My Debian packages

Some Debian packages I build for my personal use. **All builds are done by GitHub Actions directly from source code**, so there should be no trust issues.

To add this repository as source:

```shell
curl -sfL https://daniele-athome.github.io/my-debian-packages/gpg.key | sudo tee /etc/apt/keyrings/daniele-athome-my.asc
echo "deb [signed-by=/etc/apt/keyrings/daniele-athome-my.asc] https://daniele-athome.github.io/my-debian-packages/ trixie main" | sudo tee /etc/apt/sources.list.d/daniele-athome-my.list
```

In order to make apt choose my packages instead of the Debian ones, you'll need to either specify the version manually
(add `+custom1` to the Debian version) or create a file in `/etc/apt/preferences.d` containing this pinning rule:

```
Package: *
Pin: origin "daniele-athome.github.io"
Pin-Priority: 1000
```

## moonlight-qt

For some reason, the AppImage build doesn't work well without X11 (I don't know, it's probably not built with all
capabilities or something). So I decided to build it as a Debian package.

Thanks to the wonderful work of [@veldenb](https://github.com/veldenb/plugin.program.moonlight-qt) and
[@cgutman](https://github.com/cgutman/moonlight-packaging), I was able to build it using Docker. The Dockerfile is
actually a fork of the one written by @veldenb.

## kodi

> Actually only some of the Kodi packages are available. You can install them along with the other official Debian packages.

Kodi for Debian is built for the GL platform. For some reason, Kodi developers implemented HDR only for the GLES
platform. So I'm building Kodi by forcing the GLES platform. **Please note that HDR works only if Kodi is launched from
TTY** (using the command `kodi-standalone`).

This build takes the original Debian package and just patches the build script.
