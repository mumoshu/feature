#!/bin/bash

set -e

BUNDLE_GEMFILE=gemfiles/rails${RAILS_VERSION}.gemfile

TESTAPP_NAME=testapp

if [ -d $TESTAPP_NAME ]; then
  rm -Rf $TESTAPP_NAME
fi

bundle install
bundle exec rails new $TESTAPP_NAME --skip-bundle

unset BUNDLE_GEMFILE

LOCAL_FEATURE_GEM_PATH=$(bash -c 'cd ../../.. && pwd')

echo  "gem 'feature', path: '${LOCAL_FEATURE_GEM_PATH}'" >> $TESTAPP_NAME/Gemfile

cd $TESTAPP_NAME

bundle install
bundle exec rails g feature:install
bundle exec rake db:migrate
