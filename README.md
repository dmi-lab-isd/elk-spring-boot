# Spring-boot + ELK

## Endpoint usati nel tutorial

- Kibana: http://localhost:5601
- Hello (microservice): http://localhost:8080/hello

## Esecuzione

**Step 1:** Lanciare il container con tutto lo stack ELK:

```text
cd elk
chmod +x run.sh
./run.sh
```

La cartella `/etc/logstash/conf.d` verrà sostituita con la cartella `elk/conf.d` per la configurazione della pipeline di logstash.

Il container viene creato in `run.sh` usando il seguente comando:

```bash
docker run \
	-p 5601:5601 \
	-p 9200:9200 \
	-p 5044:5044 \
	-v "$(pwd)"/conf.d:/etc/logstash/conf.d:ro \
	-d --name elk sebp/elk
```

Il container espone 3 porte (bind su localhost):
- `5601` Kibana web interface
- `9200` Elasticsearch JSON interface
- `5044` Logstash: interfaccia TCP per riceve i log in formato json.

**Step 2:** Compilare ed eseguire il microservizio:
```text
mvn spring-boot:run
```

**Step 3:** Accedere all *hello* endpoint per generare dei log:
```text
curl localhost:8080/hello
```

**Step 4:** Accedere a Kibana per configurare l'accesso e la visualizzazione dei log: http://localhost:5601

## Riferimenti
- TL;DR: https://stackoverflow.com/questions/55634857/how-does-filebeats-get-invoked-when-using-logstash-in-this-java-spring-boot-app
- Introduzione a Logstash: https://www.elastic.co/blog/a-practical-introduction-to-logstash
- docker-elk (Docker Hub): https://hub.docker.com/r/sebp/elk
- docker-elk (Documentazione): https://elk-docker.readthedocs.io/
- Logstash Logback encoder: https://github.com/logstash/logstash-logback-encoder 
- Esempio spring-boot 1: https://github.com/rfding/spring-boot-elk-sample
- Esempio spring-boot 2: https://github.com/zhaoqingchris/springboot-elk-filebeat-example
- Esempio spring-boot 3 (avanzato):
https://github.com/xeraa/microservice-monitoring
- Esempi configurazione logback: https://mkyong.com/logging/logback-xml-example/
- Esempi configurazione logstash: https://www.elastic.co/guide/en/logstash/current/config-examples.html
- Tutorial: http://www.binaryheap.com/tech/programming/spring-boot-logback-and-logstash/
