# Build

FROM crystallang/crystal:1.0.0-alpine as builder

COPY make-help.cr /make-help.cr

RUN crystal build --release --static /make-help.cr

# Run

FROM scratch

COPY --from=builder /make-help /make-help

ENTRYPOINT ["/make-help"]