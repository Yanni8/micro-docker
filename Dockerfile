FROM debian:sid-slim as build

RUN mkdir /app

WORKDIR /app

COPY main.asm /app/main.asm

RUN apt-get update && apt-get install -y nasm build-essential

RUN nasm -f elf32 main.asm -o main.o
RUN ld -m elf_i386 -s main.o -o main

FROM scratch

COPY --from=build /app/main /main

ENTRYPOINT [ "/main" ]