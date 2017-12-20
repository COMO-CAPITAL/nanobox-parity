# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "parity-test"
}

@test "Verify parity installed" {
  # ensure parity executable exists
  run docker exec "parity-test" bash -c "[ -f /data/bin/parity ]"

  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "parity-test"
}
