EXECUTABLE=logstack
LOG_FILE=/var/log/${EXECUTABLE}.log
GOFMT=gofmt -w
GODEPS=go get

GOFILES=\
	main.go\

build:
	go build -o ${EXECUTABLE}

install:
	go install

format:
	${GOFMT} main.go
	${GOFMT} app/server.go
	${GOFMT} controllers/api.go
	${GOFMT} controllers/home.go
	${GOFMT} controllers/log.go
	${GOFMT} datasource/idatasource.go
	${GOFMT} datasource/mongodb.go
	${GOFMT} datasource/elasticsearch.go
	${GOFMT} models/domain/log.go
	${GOFMT} models/domain/logstat.go
	${GOFMT} models/util/util.go

test:

deps:
	${GODEPS} gopkg.in/mgo.v2/bson
	${GODEPS} github.com/prsolucoes/gowebresponse
	${GODEPS} github.com/gin-gonic/gin
	${GODEPS} gopkg.in/olivere/elastic.v3
	${GODEPS} gopkg.in/ini.v1

stop:
	pkill -f ${EXECUTABLE}

start:
	-make stop
	cd ${GOPATH}/src/github.com/prsolucoes/logstack
	nohup ${EXECUTABLE} >> ${LOG_FILE} 2>&1 </dev/null &

update:
	git pull origin master
	make install