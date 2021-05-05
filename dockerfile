FROM ubuntu:18.04

RUN apt update

ENV TZ=America/Rochester

RUN DEBIAN_FRONTEND=noninteractive apt install build-essential apache2 php git zip unzip libapache2-mod-php -y

COPY ./sample.zip sample.zip

RUN unzip sample.zip -d sample

RUN cp sample/etc/apache2/privkey.pem /etc/apache2/privkey.pem

RUN cp sample/etc/apache2/publiccert.pem /etc/apache2/publiccert.pem

RUN cp sample/etc/apache2/apache2.conf /etc/apache2/apache2.conf

RUN cp sample/etc/apache2/conf-enabled/security.conf /etc/apache2/conf-enabled/security.conf

RUN cp sample/etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN ls /etc/apache2

RUN mkdir /var/www/html/pavan

RUN echo 'sample' > /var/www/html/pavan/sample.txt

RUN echo '<?php echo "HELLO ".$_GET["name"]?>' > /var/www/html/vuln.php

RUN a2enmod ssl

COPY ./start_services.sh /etc/init.d/start_services.sh

RUN chmod +x /etc/init.d/start_services.sh

EXPOSE 80

EXPOSE 443

ENTRYPOINT ["/etc/init.d/start_services.sh"]
