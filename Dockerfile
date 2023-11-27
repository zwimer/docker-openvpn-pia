FROM fedora:39

RUN dnf install -y openvpn unzip net-tools iptables iproute && \
	mkdir /pia && \
	curl -sS "https://www.privateinternetaccess.com/openvpn/openvpn-strong.zip" -o /strong.zip && \
	unzip -q /strong.zip -d /pia/strong && \
	rm -f /strong.zip && \
	curl -sS "https://www.privateinternetaccess.com/openvpn/openvpn.zip" -o /normal.zip && \
	unzip -q /normal.zip -d /pia/normal && \
	rm -f /normal.zip && \
	dnf remove -y epel-release unzip && \
	dnf clean all && \
	groupadd -r vpn

COPY openvpn.sh /bin/openvpn.sh
WORKDIR /pia

ENV REGION="us_east"
ENV CONNECTIONSTRENGTH="strong"
ENV NETWORKINTERFACE="eth0"
ENTRYPOINT ["openvpn.sh"]
