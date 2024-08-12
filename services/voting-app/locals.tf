locals {
  project_name       = "voting-app"

  # Networking
  node_cidr_range    = "10.0.0.0/24"
  service_cidr_range = "10.0.4.0/24"
  pod_cidr_range     = "10.0.64.0/18"

  stable_channel = "STABLE"
  workdays_maintenance_reoccurrence = {
    start_time = "2020-12-01T06:00:00Z",
    end_time   = "2020-12-01T14:00:00Z",
    recurrence = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
  }
  new_year_holiday_maintenance_exclusions = [
    {
      exclusion_name = "2022 New Year"
      start_time     = "2021-12-24T00:00:00Z",
      end_time       = "2022-01-10T00:00:00Z",
    },
    {
      exclusion_name = "2023 New Year"
      start_time     = "2022-12-24T00:00:00Z",
      end_time       = "2023-01-10T00:00:00Z",
    },
    {
      exclusion_name = "2024 New Year"
      start_time     = "2023-12-24T00:00:00Z",
      end_time       = "2024-01-10T00:00:00Z",
    }
  ]
}
