FROM grafana/alloy:v1.8.3
COPY config.alloy /etc/alloy/config.alloy
CMD ["run", "--server.http.listen-addr=0.0.0.0:12345", "/etc/alloy/config.alloy"]
