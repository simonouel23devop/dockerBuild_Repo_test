# Build stage
FROM gcc:12-bookworm AS build

WORKDIR /src
COPY Main_Folder/Hello_world/Hello_world.cpp ./Hello_world.cpp

RUN mkdir -p /out && g++ -std=c++20 -O2 -Wall -Wextra -Wpedantic \
    -o /out/hello-world \
    Hello_world.cpp

# Runtime stage
FROM debian:bookworm-slim AS runtime

RUN groupadd --system --gid 10001 app && useradd --system --uid 10001 --gid 10001 --no-create-home app
COPY --from=build /out/hello-world /usr/local/bin/hello-world

USER 10001:10001
ENTRYPOINT ["/usr/local/bin/hello-world"]
