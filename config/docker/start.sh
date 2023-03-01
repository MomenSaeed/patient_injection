
#!/bin/bash

bash -c "rm -f tmp/pids/server.pid &&  bundle exec rails db:prepare && bundle exec puma -C config/puma.rb"

status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit 1
fi
