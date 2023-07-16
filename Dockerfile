FROM golang:1.20 AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

ENV CGO_ENABLED=0

COPY *.go ./
RUN go build -v -o kubevirt-commandline-hook

FROM scratch

COPY --from=build /app/kubevirt-commandline-hook /kubevirt-commandline-hook

ENTRYPOINT ["/kubevirt-commandline-hook"]
