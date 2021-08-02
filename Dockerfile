FROM ubuntu:latest
#the following ARG turns off the questions normally asked for location and timezone for Apache
ENV DEBIAN_FRONTEND=noninteractive

#install all the tools you might want to use in your container
#probably should change to apt-get install -y --no-install-recommends
RUN apt update
RUN apt install -y nano
RUN apt install -y apache2
RUN apt install libapache2-mod-fcgid
RUN a2enmod proxy
RUN a2enmod proxy_fcgi

# Install PHP-fpm &onfigure Apache to use our PHP-FPM socket for all PHP files
RUN apt install -y php7.4-fpm
RUN a2enconf php7.4-fpm
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer 
EXPOSE 80
# Now start the server
# Start PHP-FPM worker service and run Apache in foreground
CMD service php7.4-fpm start && /usr/sbin/apache2ctl -D FOREGROUND

#set working directory to where Apache serves files
#write a php file to demonstratre it is working.
