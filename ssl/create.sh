# bash create.sh "NAME OF CLUSTER"
cert="$1"

# Root CA
openssl genrsa -out root-ca-key.pem 4096
openssl req -new -x509 -sha256 -key root-ca-key.pem -out root-ca.pem -config root.cnf
# Admin cert
openssl genrsa -out admin-key-temp.pem 4096
openssl pkcs8 -inform PEM -outform PEM -in admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out admin-key.pem
openssl req -new -key admin-key.pem -out admin.csr -config admin.cnf
openssl x509 -req -in admin.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out admin.pem -extfile admin.cnf
# Node1 cert
openssl genrsa -out $1-node1-key-temp.pem 4096
openssl pkcs8 -inform PEM -outform PEM -in $1-node1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out $1-node1-key.pem
openssl req -new -key $1-node1-key.pem -out $1-node1.csr -config versprite.node1.cnf
openssl x509 -req -in $1-node1.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out $1-node1.pem -extfile node1.cnf

# node2 cert
openssl genrsa -out $1-node2-key-temp.pem 4096
openssl pkcs8 -inform PEM -outform PEM -in $1-node2-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out $1-node2-key.pem
openssl req -new -key $1-node2-key.pem -out $1-node2.csr -config versprite.node2.cnf
openssl x509 -req -in $1-node2.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out $1-node2.pem -extfile node2.cnf
# Kibana cert
openssl genrsa -out $1-kibana-key-temp.pem 4096
openssl pkcs8 -inform PEM -outform PEM -in $1-kibana-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out $1-kibana-key.pem
openssl req -new -key $1-kibana-key.pem -out $1-kibana.csr -config versprite.kibana.cnf
openssl x509 -req -in versprite-kibana.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out $1-kibana.pem -extfile kibana.cnf

cp {root-ca.pem,root-ca-key.pem,$1-node1.pem,$1-node1-key.pem,admin.pem,admin-key.pem} ../elasticsearch-node1-docker/
cp {root-ca.pem,root-ca-key.pem,$1-node2.pem,$1-node2-key.pem,admin.pem,admin-key.pem} ../elasticsearch-node-docker/
