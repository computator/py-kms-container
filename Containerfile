FROM python:3-alpine

ENV CHANGEID 56d4652de9b2a059f34d772f80ff3e152986ac23

ENV PORT 1688
ENV LCID 1033
ENV CLIENT_COUNT 26
ENV ACTIVATION_INTERVAL 120
ENV RENEWAL_INTERVAL 10080
ENV HWID "RANDOM"
ENV LOGLEVEL INFO

RUN wget https://github.com/SystemRage/py-kms/archive/${CHANGEID}.tar.gz -O /tmp/py-kms.tar.gz \
	&& mkdir -p /usr/local/lib/py-kms \
	&& tar --strip-components=2 -xf /tmp/py-kms.tar.gz py-kms-${CHANGEID}/py-kms -C /usr/local/lib/py-kms \
	&& rm -f /tmp/py-kms.tar.gz

WORKDIR /usr/local/lib/py-kms
EXPOSE ${PORT}/tcp
CMD python3 pykms_Server.py \
	0.0.0.0 \
	1688 \
	-F FILESTDOUT \
	-l ${LCID} \
	-c ${CLIENT_COUNT} \
	-a ${ACTIVATION_INTERVAL} \
	-r ${RENEWAL_INTERVAL} \
	-w ${HWID} \
	-V ${LOGLEVEL} \