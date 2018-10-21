# cc-test-reporter

Builder to easily push coverage info from Google Cloud Build to
[Code Climate](https://codeclimate.com/).

```
docker pull cloudbuilders/cc-test-reporter
```

## Motivation

We don't have `.git` on Cloud Build as our source code comes from
Google Storage. This makes the invocation of `cc-test-reporter`
to fail when running on Cloud Build.

To avoid that we need to present all the three git related env
vars, so, it won't look for git at all as mentioned at
codeclimate/test-reporter/pull/196

On another hand, we want to use this builder on other CIs that do
keep the `.git` folder available during the build, so we'll only
deal with the env vars if the `.git` folder is not present.

## Usage example

This is an example of how to push the coverage from a NodeJS app.

```yaml
steps:
  # some steps before

  - name: cloudbuilders/cc-test-reporter
    args:
      - before-build
    env:
      - GIT_COMMIT_SHA=$COMMIT_SHA
      - GIT_BRANCH=$BRANCH_NAME
      - CC_TEST_REPORTER_ID=[TEST REPORTER ID]

  - name: node:carbon
    entrypoint: yarn
    args:
      - test:coverage

  - name: cloudbuilders/cc-test-reporter
    args:
      - after-build
      - --coverage-input-type
      - lcov
    env:
      - GIT_COMMIT_SHA=$COMMIT_SHA
      - GIT_BRANCH=$BRANCH_NAME
      - CC_TEST_REPORTER_ID=[TEST REPORTER ID]

  # other steps after
```
