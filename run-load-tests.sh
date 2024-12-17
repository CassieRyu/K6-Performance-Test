#!/usr/bin/env bash

set -e

PERFORMANCE_TEST_ENV="${PERFORMANCE_TEST_ENV:-stage}"

TEST_TYPE="$1"
if [ -z "${TEST_TYPE}"]; then
    echo Missing argument - please provide test type.
    exit 1
fi

if [ -z "${USER_PASSWORD}"]; then
    echo Missing variable - please provide user password.
    exit 1
fi

#Build Load Test Projects
printf "\n\n Installing the test project...\n\n"
npm install
npm run bundle
makdir -p ./coverage-report/tests-coverage

#Run Load Tests
printf "\n\n Running the K6 Container...\n\n"
echo "Running a [$TEST_TYPE] test in the [$PERFORMANCE_TEST_ENV] environment"
docker compose run \
    -e PERFORMANCE_TEST_ENV=$PERFORMANCE_TEST_ENV -e k6_WEB_DASHBOARD=true \
    -e k6_WEB_DASHBOARD_EXPORT=/coverage-report/tests-coverage/dashboard_report_$TEST_TYPE\_$PERFORMANCE_TEST_ENV.html \
    k6 run /dist/scenario1.test.js \
    -c /src/env/$PERFORMANCE_TEST_ENV/config.$TEST_TYPE.json

printf "\n\n Complete Performance Test \n\n"