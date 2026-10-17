#!/usr/bin/env bash
# Usage: ./run-tests.sh [smoke|load|stress|all]   (JMeter must be in PATH or JMETER_HOME set)
set -e
cd "$(dirname "$0")"
JMETER="${JMETER_HOME:+$JMETER_HOME/bin/}jmeter"
run() {
  name="$1"; plan="TestPlans/CTRS_${name^}.jmx"
  rm -rf "Results/$name-report" "Results/$name.jtl"
  "$JMETER" -n -t "$plan" -l "Results/$name.jtl" -j "Results/$name.log" \
    -Jjmeter.reportgenerator.overall_granularity=5000 -e -o "Results/$name-report"
}
case "${1:-all}" in
  all) run smoke; run load; run stress ;;
  *)   run "$1" ;;
esac
