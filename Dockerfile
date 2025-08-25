FROM grafana/alloy:v1.10.2
RUN rm -rf /etc/alloy/*
COPY config/ /etc/alloy/
CMD ["run", "--server.http.listen-addr=0.0.0.0:12345", "/etc/alloy/"]
