FROM alpine:latest AS build

WORKDIR /tmp/build
RUN apk update && apk add git

RUN git clone https://github.com/OrfiTeam/OrpheusDL.git 

WORKDIR /tmp/build/OrpheusDL
RUN git clone https://github.com/uhwot/orpheusdl-deezer modules/deezer
RUN git clone --recurse-submodules https://github.com/Dniel97/orpheusdl-tidal.git modules/tidal

FROM python:3.9-alpine

WORKDIR /app  
COPY --from=build /tmp/build/OrpheusDL /app 
RUN pip install -r requirements.txt


ENTRYPOINT ["python3", "orpheus.py"]
CMD ["settings refresh"]