# bash create.sh "NAME OF CLUSTER"

# Root CA
openssl genrsa -out root-ca-key.pem 4096
openssl req -new -x509 -sha256 -key root-ca-key.pem -out root-ca.pem -config root.cnf
# Admin cert
openssl genrsa -out admin-key-temp.pem 4096
openssl pkcs8 -inform PEM -outform PEM -in admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out admin-key.pem
openssl req -new -key admin-key.pem -out admin.csr -config admin.cnf
openssl x509 -req -in admin.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out admin.pem -extfile admin.cnf
# Node1 cert
openssl genrsa -out node1-key-temp.pem 4096
openssl pkcs8 -inform PEM -outform PEM -in node1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node1-key.pem
openssl req -new -key node1-key.pem -out node1.csr -config node1.cnf
openssl x509 -req -in node1.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out node1.pem -extfile node1.cnf

# node2 cert
openssl genrsa -out node2-key-temp.pem 4096
openssl pkcs8 -inform PEM -outform PEM -in node2-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node2-key.pem
openssl req -new -key node2-key.pem -out node2.csr -config node2.cnf
openssl x509 -req -in node2.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out node2.pem -extfile node2.cnf
# Kibana cert
openssl genrsa -out kibana-key-temp.pem 4096
openssl pkcs8 -inform PEM -outform PEM -in kibana-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out kibana-key.pem
openssl req -new -key kibana-key.pem -out kibana.csr -config kibana.cnf
openssl x509 -req -in kibana.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out kibana.pem -extfile kibana.cnf

cp {root-ca.pem,root-ca-key.pem,node1.pem,node1-key.pem,admin.pem,admin-key.pem} ../elasticsearch-node1-docker/
cp {root-ca.pem,root-ca-key.pem,node2.pem,node2-key.pem,admin.pem,admin-key.pem} ../elasticsearch-node-docker/
