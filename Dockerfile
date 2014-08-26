# Create an up-to-date Arch environment
FROM base/archlinux
RUN pacman -Syu --noconfirm

# Install Go and apply a temporary fix to the installed standard library
# packages being stale
RUN pacman -S --noconfirm go
RUN go install std

# Install git and other VCS tools
RUN pacman -S --noconfirm git mercurial bzr svn

# Set the GOPATH
RUN mkdir -p /go
ENV GOPATH /go

# Copy the source code into the container
RUN mkdir -p /go/src/app
ADD . /go/src/app

# Build and install the app in the GOPATH
RUN go install app

# Run the app as the container command
CMD /go/bin/app
