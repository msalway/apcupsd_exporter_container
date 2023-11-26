FROM docker.io/golang AS builder

RUN adduser \    
    --disabled-password \    
    --gecos "" \    
    --home "/nonexistent" \    
    --shell "/sbin/nologin" \    
    --no-create-home \    
    --uid "10001" \    
    "appuser"

COPY src/apcupsd_exporter /go/src/apcupsd_exporter

WORKDIR /go/src/apcupsd_exporter/cmd/apcupsd_exporter

RUN go build -o /go/bin/apcupsd_exporter

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /go/bin/apcupsd_exporter /go/bin/apcupsd_exporter
COPY --from=builder /lib/ld-linux-aarch64.so.1 /lib/ld-linux-aarch64.so.1
COPY --from=builder /lib/aarch64-linux-gnu/libc.so.6 /lib/aarch64-linux-gnu/libc.so.6

USER 10001:10001

ENTRYPOINT ["/go/bin/apcupsd_exporter"]
