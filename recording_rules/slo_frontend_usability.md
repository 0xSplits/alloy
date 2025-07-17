```yaml
# Calculate the SLO for the teams frontend in all environments. The basis of the
# SLO is 1. The error budget taking away from the SLO is represented by pages
# that take too long to become ready for the user. We multiply the resulting
# ratio by 100, because the SLO is represented as percent. Note that we
# aggregate 1 hour queries, instead of 5 minute queries, because we are working
# with rather sparse data here at the moment.
#
#     100 * ( 1 - latency SLO )
#
#     https://www.notion.so/splits/Service-Level-Objectives-208f7c3c8eff80bf9efcf1b1b9d4b105?source=copy_link#208f7c3c8eff8096af5efe11b5d682df
#
100 * (
    1

    -

    # Calculate the average ratio of slow pages, over a 24 hour rolling
    # window. The resulting error ratio is taking away from the SLO basis above.
    #
    #     all latencies - 500ms latencies
    #     -------------------------------
    #              all latencies
    #
    avg_over_time(
        (
            (
                sum by (env) (rate(page_ready_duration_seconds_bucket{page="root", le="+Inf"}[1h]))
                -
                sum by (env) (rate(page_ready_duration_seconds_bucket{page="root", le="0.5"}[1h]))
            )

            /

            (
                sum by (env) (rate(page_ready_duration_seconds_bucket{page="root", le="+Inf"}[1h]))
            )
        )[1d:]
    )
)
```
