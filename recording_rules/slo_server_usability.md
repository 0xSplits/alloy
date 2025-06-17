```yaml
# Calculate the SLO for the server component in all environments. The basis of
# the SLO are all successful requests as specified in the docs. The error budget
# taking away from the SLO is represented by requests responding with failed
# status codes, and requests that take too long to respond. We multiply the
# resulting ratio by 100, because the SLO is represented as percent.
#
#     100 * ( status code SLO - latency SLO )
#
#     https://www.notion.so/splits/Service-Level-Objectives-208f7c3c8eff80bf9efcf1b1b9d4b105?source=copy_link#208f7c3c8eff8096af5efe11b5d682df
#
100 * (
    # Calculate the average ratio of successful requests, by status code, over a
    # 24 hour rolling window. The resulting ratio is the basis of the SLO. The
    # latency query below is taking away from this basis.
    #
    #     successful requests | 0
    #     -----------------------
    #         all requests | 1
    #
    avg_over_time(
        (
            (sum by (env) (rate(http_request_duration_seconds_count{job="splits_server", middleware="root", route!~"/api/admin/*", code=~"2..|3..|404"}[5m])) OR vector(0))
            /
            (sum by (env) (rate(http_request_duration_seconds_count{job="splits_server", middleware="root", route!~"/api/admin/*", code!=""}[5m])) OR vector(1))
        )[1d:]
    )

    -

    # Calculate the average ratio of slow requests, over a 24 hour rolling
    # window. The resulting error ratio is taking away from the SLO basis above.
    #
    #     all latencies - 500ms latencies
    #     -------------------------------
    #              all latencies
    #
    avg_over_time(
        (
            (
                sum by (env) (rate(http_request_duration_seconds_bucket{job="splits_server", middleware="root", route!~"/api/admin/*", le="+Inf"}[5m]))
                -
                sum by (env) (rate(http_request_duration_seconds_bucket{job="splits_server", middleware="root", route!~"/api/admin/*", le="0.5"}[5m]))
            )

            /

            (
                sum by (env) (rate(http_request_duration_seconds_bucket{job="splits_server", middleware="root", route!~"/api/admin/*", le="+Inf"}[5m]))
            )
        )[1d:]
    )
)
```
