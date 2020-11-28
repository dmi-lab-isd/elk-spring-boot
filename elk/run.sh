docker run \
	-p 5601:5601 \
	-p 9200:9200 \
	-p 5044:5044 \
	-v "$(pwd)"/conf.d:/etc/logstash/conf.d:ro \
	-d --name elk sebp/elk