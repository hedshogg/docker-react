This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Docker notes

We have docker configuration for multiple kinds of environment, including development. These files are named `Dockerfile.<env>`, so the development container is described by `Dockerfile.dev`.

### Development

To create a development container use the command

```sh
docker build -f Dockerfile.dev .
```

Run with:

```sh
docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app <container id>
```

In the above command the first `-v` sets up an exclusion to the volume (called a bookmark in the course material) that comes next. i.e. /app/node_modules is not replaced by the volume mapping `-v $(pwd):/app`.
Not sure if the order of these is important - but it seems to be.

Note the above doesn't work in Windows cmd or pwsh.

Note that the `docker-compose.yml` works in Windows as it contains the environment variable `CHOKIDAR_USEPOLLING=true` which allows the container to poll for changes to the host. This is not required if the container is writing to the volume, only if it needs to respond to changes made outside the container.
This environment variable is not required for Linux/OS X.

Even though we are using volumes for our application in docker-compose, we should still use `COPY . .` so that the container can/will work without using docker-compose.

### Testing

Testing doesn't need a separate container, we will re-use the same one as for development.

To run the tests in the container use:

```sh
docker run -it <container_id> npm run test
```

Note that the docker-compose version of `test` service only re-runs tests on Linux and OS X. It's broken on Windows. On windows, the way to run this is to start the container (`docker-compose up`) and then run the command

```bat
docker exec -it <container_id> npm run test
```

### Production

The production build is a multi-step build, and is contained in `Dockerfile`. Note that we don't use a suffix.

```sh
docker build .
```

To run this, use

```sh
docker run -p 8080:80 <container_id>
```

This will start up nginx and forward traffic from port 8080 to the container's port 80.

## Continuous integration with Travis-CI

Travis integrates with GitHub (Bitbucket can be integrated via 3rd parties such as Cloudpipes - https://www.cloudpipes.com/integrations/bitbucket/travis).

Note also that it is possible to build docker images in Jenkins, see https://www.katacoda.com/courses/jenkins/build-docker-images for a 20 minute description.

The course covers building and testing the containers from GitHub using Travis-CI, so that's what will be here.

## Available Scripts

In the project directory, you can run:

### `yarn start`

Runs the app in the development mode.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br />
You will also see any lint errors in the console.

### `yarn test`

Launches the test runner in the interactive watch mode.<br />
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `yarn build`

Builds the app for production to the `build` folder.<br />
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br />
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `yarn eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (Webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: https://facebook.github.io/create-react-app/docs/code-splitting

### Analyzing the Bundle Size

This section has moved here: https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size

### Making a Progressive Web App

This section has moved here: https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app

### Advanced Configuration

This section has moved here: https://facebook.github.io/create-react-app/docs/advanced-configuration

### Deployment

This section has moved here: https://facebook.github.io/create-react-app/docs/deployment

### `yarn build` fails to minify

This section has moved here: https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify
