#!/bin/sh

# We don't have .git on Cloud Build as our source code comes from
# Google Storage. This makes the invocation of cc-test-reporter
# to fail when runnig on Cloud Build.

# To avoid that we need to present all the three git related env
# vars, so it won't look for git at all.
# https://github.com/codeclimate/test-reporter/pull/196

# On other hand, we want to use this builder on other CIs that do
# keep the .git folder available durig the build, so we'll only
# deal with the env vars if the .git folder is not present.

if [ -d .git ]; then
  echo "[INFO] .git folder is present"
else
  echo "[INFO] .git folder is absent"
  echo "[INFO] Enforcing the env vars"

  if [ -z $GIT_COMMITED_AT ]; then
    echo "[WARN] GIT_COMMITED_AT not declared: assuming its value"
    export GIT_COMMITED_AT=$(date +"%s")
  fi

  echo "[INFO] GIT_BRANCH=${GIT_BRANCH}"
  echo "[INFO] GIT_COMMIT_SHA=${GIT_COMMIT_SHA}"
  echo "[INFO] GIT_COMMITED_AT=${GIT_COMMITED_AT}"

  if [ -z $GIT_COMMIT_SHA ] || [ -z $GIT_BRANCH ]; then
    echo "[ERROR] You must inform both GIT_BRANCH and GIT_COMMIT_SHA"
    exit 1
  fi
fi

echo "[INFO] Invoking cc-test-reporter $@"
cc-test-reporter $@
