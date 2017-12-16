#!/bin/bash

VERSION=$1

cd target

tar -xf jobson-$VERSION-bin.tar.gz

cat <<EOF > jobson
#!/bin/bash

java -jar '/usr/share/java/jobson-$VERSION.jar' "\$@"
EOF

chmod 755 jobson

fpm \
    --force \
    --input-type dir \
    --output-type deb \
    --name jobson \
    --version $VERSION \
    --depends "default-jre" \
    --maintainer "Adam Kewley <contact@adamkewley.com>" \
    --url "https://github.com/adamkewley/jobson" \
    --description "A web server that can turn command-line applications into a job system." \
    --license "Apache-2.0" \
    jobson-$VERSION/jobson-$VERSION.jar=/usr/share/java/jobson-$VERSION.jar \
    ./jobson=/usr/bin/jobson
