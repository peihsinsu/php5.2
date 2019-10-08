FROM tommylau/php-5.2

RUN apt-get update \
    && apt-get install -y --force-yes libgmp-dev wget \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && cd /tmp \
    && wget --no-check-certificate https://museum.php.net/php5/php-5.2.16.tar.gz \
    && tar xvf php-5.2.16.tar.gz \
    && cd php-5.2.16/ext/gmp \
    && sed -i 's/__GMP_BITS_PER_MP_LIMB/GMP_LIMB_BITS/g' gmp.c \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd ../bcmath \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && printf "extension=gmp.so\nextension=bcmath.so" > /usr/local/etc/php/php.ini