# QbsProjectExample
QtCreator QBS project template with build script.

Code style: **WebKit**



# Tips

## Genetate clang-format configuration
```bash
clang-format -style=webkit -dump-config > .clang-format
``` 

## Build project from console for host.
```bash
./build.sh --project ./QbsProjectExample.qbs
```