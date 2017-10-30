# docker-unity3d (Docker container for Unity)
Just run `docker-compose up -d`, and you're okay. Your Unity container should be running when build is done.

## Where do I put my projects?
There is a directory `/context` which is shared volume, so you can put your projects there.

## How do I access Unity?
By VNC, use your favorite VNC viewer and connect to `172.16.250.10` with `pass123` as password. Also, you can change default password in `docker-compose.yml`, specified as environment variable `VNC_PASSWORD`.

Once you're connected run `/opt/Unity/Editor/Unity` and register/login with your UnityID credentials.

## Accessing container for any other reason
Of course, if you need bash for any reason just do `docker exec -it unity-service bash`.

## Other things to mention

### User
Since Unity on Linux complains about running as `root` which is Docker's default, we have `adminuser` here who is also sudoer with no password. So if you need to do something you can either `sudo something` without password, or `docker exec -it --username root bash` and do stuff as root.

### Activating Unity and using it in some CI scenario
I specifically made this with `unity-editor_amd64-5.6.0xf3Linux` version because I needed it for one super-secret project. Unfortunately that version doesn't support activating via command line parameters. If you need that use version 2017.2 or later which has `--username`, `--password` and `--serial` parameters which allows you to streamline whatever you're up to.



### Donations
If you think this is okay and want to send me money so I can buy myself an exotic beer, you can do it on following addresses.

BTC: 12YfQwemCs5jQ8Z6NuMGJVBGVp4D2voQZR
