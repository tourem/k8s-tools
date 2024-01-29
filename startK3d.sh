k3d cluster create devcluster --servers 1 --agents 2 --api-port 127.0.0.1:6445 --k3s-arg "--disable=traefik@server:0" -p "8081:30090@agent:0" -p "443:30091@agent:0" -p "8200:30080@agent:0" -p "27017:30070@agent:0"  -p "5432:30060@agent:0" --registry-use k3d-dev-app-registry:5050 --registry-config /Users/mtoure/k3d/dev-registries.yaml --wait

#k3d cluster create devcluster --k3s-arg '--pause-image=rancher/mirrored-pause:3.6@all:*' --k3s-arg '--disable=metrics-server@all:*' --k3s-arg '--disable=traefik@all:*' --servers 1 --agents 2 --api-port 127.0.0.1:6445 --volume /Users/mtoure/dev/zephyr/local-dev/mongo/data:/tmp/db/data --volume /Users/mtoure/dev/zephyr/local-dev/mongo/config:/tmp/db/config --volume /Users/mtoure/dev/zephyr/local-dev/vault/data:/tmp/vault/data --registry-use k3d-dev-app-registry:5050 --registry-config /Users/mtoure/k3d/dev-registries.yaml --wait

k3d image import rancher/mirrored-pause:3.6 -c devcluster

sleep 15

kubectl -n kube-system set image deployment/coredns coredns=k3d-dev-app-registry:5050/rancher/mirrored-coredns-coredns:1.9.1
kubectl -n kube-system set image deployment/local-path-provisioner local-path-provisioner=k3d-dev-app-registry:5050/rancher/local-path-provisioner:v0.0.21
kubectl -n kube-system set image deployment/metrics-server metrics-server=k3d-dev-app-registry:5050/rancher/mirrored-metrics-server:v0.5.2


#for pod in $(kubectl -n kube-system  get pods -o=name | grep helm-install-traefik); do
#	kubectl -n kube-system set image $pod helm=k3d-dev-app-registry:5050/rancher/klipper-helm:v0.7.3-build20220613
#done

#sleep 15

#kubectl -n kube-system set image deployment/traefik traefik=k3d-dev-app-registry:5050/rancher/mirrored-library-traefik:2.6.2

#for pod in $(kubectl -n kube-system  get pods -o=name | grep svclb-nginx-ingress-controller); do
#	kubectl -n kube-system set image $pod lb-tcp-80=k3d-dev-app-registry:5050/rancher/klipper-lb:v0.3.5 lb-tcp-443=k3d-dev-app-registry:5050/rancher/klipper-lb:v0.3.5
#done


get ======================================
#!/bin/bash
 
set -euo pipefail
 
fileLocal="/Users/mtoure/dev/data/20231002_XXXXXXXX_20231002_K0303021.zip"
if [[ ! -d "$(dirname ${fileLocal})" ]]; then
    echo "ERROR: Must create directory to store '${fileLocal}'" >&2
    exit 1
fi
 
 
# URL-encode the filename we pass
 
awsSecret='xxxxxxxxxxxxxxxxxc42b57bcc355304570eccceafd2d8xxxxxxxxxxxx'
awsAccess='xxxxxxxxee4e6a96b263db2xxxx'
awsRegion=eu-fr2
# Initialize helper variables
httpReq='GET'
authType='AWS4-HMAC-SHA256'
service='s3'
host="host-s3"
fullUrl="https://${host}:4212/20231002_XXXXXXXX_20231002_K0303021.zip"
dateValueS=$(date -u +'%Y%m%d')
dateValueL=$(date -u +'%Y%m%dT%H%M%SZ')
 
 
# Helper function to sign the pieces of a request
awsStringSign4() {
  kSecret="AWS4$1"
  kDate=$(printf         '%s' "$2" | openssl dgst -sha256 -hex -mac HMAC -macopt    "key:${kSecret}"  2>/dev/null | sed 's/^.* //')
  kRegion=$(printf       '%s' "$3" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kDate}"    2>/dev/null | sed 's/^.* //')
  kService=$(printf      '%s' "$4" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kRegion}"  2>/dev/null | sed 's/^.* //')
  kSigning=$(printf 'aws4_request' | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kService}" 2>/dev/null | sed 's/^.* //')
  signedString=$(printf  '%s' "$5" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kSigning}" 2>/dev/null | sed 's/^.* //')
  printf '%s' "${signedString}"
}
 
# 0. Hash the payload (in this case, the empty file)
payloadHash=$(openssl dgst -sha256 -hex </dev/null 2>/dev/null | sed 's/^.* //')
 
# 1. Create canonical request
# NOTE: order significant in ${headerList} and ${canonicalRequest}
headerList='host;x-amz-content-sha256;x-amz-date'
canonicalRequest="\
${httpReq}
/20231002_XXXXXXXX_20231002_K0303021.zip
 
host:${host}
x-amz-content-sha256:${payloadHash}
x-amz-date:${dateValueL}
 
${headerList}
${payloadHash}"
 
# Hash it
canonicalRequestHash=$(printf '%s' "${canonicalRequest}" | openssl dgst -sha256 -hex 2>/dev/null | sed 's/^.* //')
 
# 2. Create string to sign
stringToSign="\
${authType}
${dateValueL}
${dateValueS}/${awsRegion}/${service}/aws4_request
${canonicalRequestHash}"
 
# 3. Sign the string
signature=$(awsStringSign4 "${awsSecret}" "${dateValueS}" "${awsRegion}" "${service}" "${stringToSign}")
 
# Upload
if [[ $@ != *--quiet* ]]; then
  echo "${fullUrl} -> ${fileLocal}"
fi
curl --fail --location --proto-redir =https --request "${httpReq}" -o "${fileLocal}" \
  --header "Host: ${host}" \
  --header "X-Amz-Content-SHA256: ${payloadHash}" \
  --header "X-Amz-Date: ${dateValueL}" \
  --header "Authorization: ${authType} Credential=${awsAccess}/${dateValueS}/${awsRegion}/${service}/aws4_request, SignedHeaders=${headerList}, Signature=${signature}" \
  "${fullUrl}"
  ===================================================================

  put --------------------------------------------------------

  #!/bin/bash
 
set -euo pipefail
 
# Automatically determine the MIME type using `file`, if it's available
if command -v file >/dev/null 2>&1; then
  get_mimetype() { file --brief --mime-type "${1}"; }
else
  get_mimetype() { echo "application/octet-stream"; }
fi
 
awsStringSign4() {
  kSecret="AWS4$1"
  kDate=$(printf         '%s' "$2" | openssl dgst -sha256 -hex -mac HMAC -macopt    "key:${kSecret}"  2>/dev/null | sed 's/^.* //')
  kRegion=$(printf       '%s' "$3" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kDate}"    2>/dev/null | sed 's/^.* //')
  kService=$(printf      '%s' "$4" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kRegion}"  2>/dev/null | sed 's/^.* //')
  kSigning=$(printf 'aws4_request' | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kService}" 2>/dev/null | sed 's/^.* //')
  signedString=$(printf  '%s' "$5" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kSigning}" 2>/dev/null | sed 's/^.* //')
  printf '%s' "${signedString}"
}
 
# Extract `bucket` and `pathRemote`:
bucket="bu002ixxxxxx"
 
awsSecret='4e2e3a463ccafd2d82dc539c'
awsAccess='f8cc077c63db2761ade2'
awsRegion=eu-fr2
# Initialize helper variables
httpReq='PUT'
authType='AWS4-HMAC-SHA256'
service='s3'
host="host-s3"
fullUrl="https://${host}:4361/test-teradata-v4.txt"
dateValueS=$(date -u +'%Y%m%d')
dateValueL=$(date -u +'%Y%m%dT%H%M%SZ')
 
 
# 0. Hash the file to be uploaded
payloadHash=$(openssl dgst -sha256 -hex < "${fileLocal}" 2>/dev/null | sed 's/^.* //')
 
# 1. Create canonical request
# NOTE: order significant in ${headerList} and ${canonicalRequest}
contentType="$(get_mimetype "${fileLocal}")"
headerList='content-type;host;x-amz-content-sha256;x-amz-date;x-amz-storage-class'
canonicalRequest="\
${httpReq}
/test-teradata-v4.txt
 
content-type:${contentType}
host:${host}
x-amz-content-sha256:${payloadHash}
x-amz-date:${dateValueL}
x-amz-storage-class:STANDARD
 
${headerList}
${payloadHash}"
 
# Hash it
canonicalRequestHash=$(printf '%s' "${canonicalRequest}" | openssl dgst -sha256 -hex 2>/dev/null | sed 's/^.* //')
 
# 2. Create string to sign
stringToSign="\
${authType}
${dateValueL}
${dateValueS}/${awsRegion}/${service}/aws4_request
${canonicalRequestHash}"
 
# 3. Sign the string
signature=$(awsStringSign4 "${awsSecret}" "${dateValueS}" "${awsRegion}" "${service}" "${stringToSign}")
 
# Upload
if [[ $@ != *--quiet* ]]; then
  echo "${fileLocal} -> ${fullUrl}"
fi
curl -vv -X --fail --location --proto-redir =https --request "${httpReq}" --upload-file "${fileLocal}" \
  --header "Content-Type: ${contentType}" \
  --header "Host: ${host}" \
  --header "X-Amz-Content-SHA256: ${payloadHash}" \
  --header "X-Amz-Date: ${dateValueL}" \
  --header "X-Amz-Storage-Class: STANDARD" \
  --header "Authorization: ${authType} Credential=${awsAccess}/${dateValueS}/${awsRegion}/${service}/aws4_request, SignedHeaders=${headerList}, Signature=${signature}" \
  "${fullUrl}"

  --------------------------------------------------------------------

  list of keys 

  #!/bin/bash
 
# URL-encode the filename we pass
 
awsSecret='xxxxxxxxxxxxxxxx7bcc355304570eccceafd2d82dc539c'
awsAccess='aaaaaaaaaaaaaaaaaaaaee4e6a96b263db2761ade2'
awsRegion=eu-fr2
# Initialize helper variables
httpReq='GET'
authType='AWS4-HMAC-SHA256'
service='s3'
host="host-s3"
fullUrl="https://${host}:4212/?max-keys=20&prefix=bu002i00xxxx"
dateValueS=$(date -u +'%Y%m%d')
dateValueL=$(date -u +'%Y%m%dT%H%M%SZ')
 
 
# Helper function to sign the pieces of a request
awsStringSign4() {
  kSecret="AWS4$1"
  kDate=$(printf         '%s' "$2" | openssl dgst -sha256 -hex -mac HMAC -macopt    "key:${kSecret}"  2>/dev/null | sed 's/^.* //')
  kRegion=$(printf       '%s' "$3" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kDate}"    2>/dev/null | sed 's/^.* //')
  kService=$(printf      '%s' "$4" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kRegion}"  2>/dev/null | sed 's/^.* //')
  kSigning=$(printf 'aws4_request' | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kService}" 2>/dev/null | sed 's/^.* //')
  signedString=$(printf  '%s' "$5" | openssl dgst -sha256 -hex -mac HMAC -macopt "hexkey:${kSigning}" 2>/dev/null | sed 's/^.* //')
  printf '%s' "${signedString}"
}
 
# 0. Hash the payload (in this case, the empty file)
payloadHash=$(openssl dgst -sha256 -hex </dev/null 2>/dev/null | sed 's/^.* //')
 
# 1. Create canonical request
# NOTE: order significant in ${headerList} and ${canonicalRequest}
headerList='host;x-amz-content-sha256;x-amz-date'
canonicalRequest="\
${httpReq}
/
max-keys=20&prefix=bu002i00xxxx
host:${host}
x-amz-content-sha256:${payloadHash}
x-amz-date:${dateValueL}
 
${headerList}
${payloadHash}"
 
# Hash it
canonicalRequestHash=$(printf '%s' "${canonicalRequest}" | openssl dgst -sha256 -hex 2>/dev/null | sed 's/^.* //')
 
# 2. Create string to sign
stringToSign="\
${authType}
${dateValueL}
${dateValueS}/${awsRegion}/${service}/aws4_request
${canonicalRequestHash}"
 
# 3. Sign the string
signature=$(awsStringSign4 "${awsSecret}" "${dateValueS}" "${awsRegion}" "${service}" "${stringToSign}")
 
# xq to format xml
curl -X --fail --location --proto-redir =https --request "${httpReq}" \
  --header "Host: ${host}" \
  --header "X-Amz-Content-SHA256: ${payloadHash}" \
  --header "X-Amz-Date: ${dateValueL}" \
  --header "Authorization: ${authType} Credential=${awsAccess}/${dateValueS}/${awsRegion}/${service}/aws4_request, SignedHeaders=${headerList}, Signature=${signature}" \
  "${fullUrl}" | xq
  
