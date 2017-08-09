FROM {{ base_img_reg }}{{ base_img_name }}:{{ base_img_tag }}

LABEL MAINTAINER ...

ENV NAME=mycontainer VERSION=0 RELEASE=1 ARCH=x86_64

LABEL summary="A container that tells you how awesome it is." \
      com.redhat.component="$NAME" \
      version="$VERSION" \
      release="$RELEASE.$DISTTAG" \
      architecture="$ARCH" \
      usage="docker run -p 9000:9000 mycontainer" \
      help="Runs mycontainer, which listens on port 9000 and tells you how awesome it is. No dependencies." \
      description="{{ description }}" \
      vendor="{{ vendor }}" \
      org.fedoraproject.component="postfix" \
      authoritative-source-url="{{ authoritative_source_url }}" \
      io.k8s.description="{{ description }}" \
      io.k8s.display-name="Awesome container with SW version {{ software_version }}" \
      io.openshift.expose-services="9000:http" \
      io.openshift.tags="some,tags"

EXPOSE 9000

# We don't actually use the "software_version" here, but we could,
#  e.g. to install a module with that ncat version
RUN {{ installer }} install -y nmap-ncat && \
    {{ installer }} clean all

# add help file
COPY root /
COPY script.sh /usr/bin/

CMD ["/usr/bin/script.sh"]
