# Whats this?

This is custom shell configure

---

## How to install?

```terminal
$ cd bash
$ sudo ./Install.bash
```

## Develop environment

```terminal
$ sudo apt install shellcheck
$ go install github.com/mvdan/sh/cmd/shfmt@latest
```

## Directory Tree

```bash
bash/
├── alias/      # command alias settings by OS
├── bind/       # key bind settings by OS
├── cache/      # cache directory managed by ${CACHE}
├── conf.d/     # setting files e.g. status variables
├── functions/  # function definitions
├── readline/   # readline settings
└── config.bash # load above files as main method
```
