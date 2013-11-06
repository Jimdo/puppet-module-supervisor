Needs a test host with:

 * a passwordless root ssh access
 * puppet
 * supervisor module in puppet modulepath

Configure test host via `SERVERSPEC_HOST` environment variable

    export SERVERSPEC_HOST=192.168.10.10
