FROM grafana/alloy:v1.8.3
COPY config/ /etc/alloy/
CMD ["run", "--server.http.listen-addr=0.0.0.0:12345", "/etc/alloy/"]
