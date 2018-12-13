FROM debian:9-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends apt-transport-https lsb-release ca-certificates curl software-properties-common gnupg2 git zip unzip \
  && curl -sL https://packages.sury.org/php/apt.gpg -o /etc/apt/trusted.gpg.d/php.gpg \
  && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
  && apt-get update \
  && apt-get install -y --no-install-recommends php7.1 php7.1-common php7.1-cli php7.1-fpm php7.1-mysql php7.1-gd php7.1-soap php7.1-ldap php7.1-intl php7.1-xml php7.1-mbstring php7.1-zip php7.1-curl php7.1-apcu php7.1-xdebug \
  && php -v \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=bin  --filename=composer \
  && composer global require hirak/prestissimo \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*