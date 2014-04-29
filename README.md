imgpblshr
=========

Just a silly tool to share images on a monitor in the office.
With websockets support.
For the lulz.

Usage in development
--------------------

Set the Redis URL using Heroku toolset:

    export REDISTOGO_URL=`heroku config:get REDISTOGO_URL`

Usage in production
-------------------

1. Choose a scope: `/this-is-a-scope/`
2. In `/this-is-a-scope/push` page paste an image URL and click the `Send` button
3. Watch at `/this-is-a-scope/`
4. Enjoy!
