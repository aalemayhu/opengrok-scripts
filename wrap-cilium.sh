#!/bin/bash

cat <<EOF > /usr/local/bin/cilium
#!/bin/bash

docker exec -ti cilium cilium \$@
EOF

chmod +x /usr/local/bin/cilium
