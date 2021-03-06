# Terraform Registry

terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
      version = "3.1.2"
    }
  }
}

provider "datadog" {
  api_url = var.datadog_api_url
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Monitors

resource "datadog_monitor" "cpu_utlization" {
  name               = "[${upper(var.environment)}] - CPU utilization on {{host.name}}"
  type               = "metric alert"
  message            = <<MESSAGE

CPU utilization threshold exceeded.

{{#is_alert}}
CRITICAL! {{host.name}}
{{/is_alert}}

{{#is_recovery}}
The CPU load is back to normal
{{/is_recovery}}

Runbook:

- Do X

- Do Y

- Review detailed runbook https://fake-corp-wiki.io/foo

@slack-${var.team}-channel
MESSAGE

  query = "avg(last_5m):avg:system.cpu.user{env:${var.environment}} by {host} >= ${var.critical_threshold}"

  monitor_thresholds {
    warning           = "0.3"
    warning_recovery  = "0.2"
    critical          = "${var.critical_threshold}"
    critical_recovery = "0.4"
  }

  notify_no_data    = false
  renotify_interval = 60

  notify_audit = false
  timeout_h    = 60
  include_tags = true

  priority = 1

  tags = ["env:${var.environment}", "team:${var.team}", "tf_module:true"]
}
