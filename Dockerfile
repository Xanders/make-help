# Build

FROM crystallang/crystal:0.35.1-alpine as builder

COPY make-help.cr /make-help.cr

RUN crystal build --release --static /make-help.cr

# Run

FROM scratch

COPY --from=builder /make-help /make-help

ENTRYPOINT ["/make-help"]