resource "datadog_monitor" "app-checker" {
  name               = "App checker"
  type               = "metric alert"
  message            = "App is dead!"

  query = "avg(last_5m):min:http.can_connect{*} by {host} < 1"

  monitor_thresholds {
    critical = 1
  }
}
