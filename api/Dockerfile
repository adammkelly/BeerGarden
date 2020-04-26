FROM golang:latest

# Set the Current Working Directory inside the container
WORKDIR /app

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
#RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .
RUN go mod download

# Build the Go app
CMD CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .
