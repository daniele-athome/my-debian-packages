# My Debian packages

Some Debian packages I build for my personal use.

All packages are available as GitHub Actions artifacts: feel free to download and use them.

> [!NOTE]
> I might use GitHub releases one day and put the packages there.

## moonlight-qt

For some reason, the AppImage build doesn't work well without X11 (I don't know, it's probably not built with all
capabilities or something). So I decided to build it as a Debian package.

Thanks to the wonderful work of [@veldenb](https://github.com/veldenb/plugin.program.moonlight-qt) and
[@cgutman](https://github.com/cgutman/moonlight-packaging), I was able to build it using Docker. The Dockerfile is
actually a fork of the one written by @veldenb.

## kodi

Kodi for Debian is built for the GL platform. For some reason, Kodi developers implemented HDR only for the GLES
platform. So I'm building Kodi by forcing the GLES platform.

This build takes the original Debian package and just patches the build script.
