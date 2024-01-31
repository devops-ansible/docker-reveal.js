# reveal.js – HTML presentation framework

This repo provides a small `reveal.js` container image with once a week check if a new version was released and the container image will be built and published.

For ease of explaination, we assume you'll call the running container at `http://localhost:8000`, so either you run it binding the port actively to `8000` on your machine or just use host networking functionalities since the container exposes the service at `8000`.

## Working directory

Everything is hold in the `/reveal.js` directory within the container. So if you want to access your

## Environmental variables

| env                   | default               | change recommended | description |
| --------------------- | --------------------- |:------------------:| ----------- |
| **KEEP\_DEFAULTS**    | `true`                | yes                | Any other value than `true` (case sensitive) will delete unnecessary and not mounted files and directories. The deleted files are listed below as optional files. |
| **TERM**              | `xterm`               | no                 | set terminal type – default `xterm` provides 16 colors |
| **DEBIAN\_FRONTEND**  | `noninteractive`      | no                 | set frontent to use – default self-explaining |


The variable `NODE_ENV` is not used – since `reveal.js` is only using `devDependencies`. For that, we need the node environment to always stay in DEV mode ...

## optional Files

* `index.html` – the `index.html` prevents the directory listing as it is an index file. You maybe want to bind a file there – even if it's an empty one.
* `.github`, `.gitignore`, `.npmignore` – those are managing directories and files for the `reveal.js` repo ... in production, they are useless
* `package.json`, `package-lock.json` – the dependency installation files for `reveal.js` ... Installation is done on Image build process, so afterwards in production they are no longer needed.
* `test` – test cases that can be run to check if everything is working as expected. They are not necessary for running the product
* `examples`, `demo.html` – demonstration presentations which are not necessary for production

## last built

0000-00-00 00:00:00
