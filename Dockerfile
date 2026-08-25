FROM golang:1.25-alpine AS builder
WORKDIR /app
COPY shared/go shared/go
COPY backend/telemetry-service backend/telemetry-service
WORKDIR /app/backend/telemetry-service
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/server/main.go

FROM scratch
WORKDIR /app
COPY --from=builder /app/backend/telemetry-service/main .
CMD ["./main"]
