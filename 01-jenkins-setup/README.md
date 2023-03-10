
## Setup Architecture 

<p align="center">
<img src="https://user-images.githubusercontent.com/106984297/224294117-bf4fb81d-f8c2-40fa-90b3-82124687fea7.png" width="856" height="832">
</p>


## Setup Workflow

EFS is setup in us-west-2a
Jenkins should be launchd in us-west-2a to access EFS

## Packer

Get AMI ID

```

#!/bin/bash

AMI_ID=$(jq -r '.builds[-1].artifact_id' manifest.json | cut -d ":" -f2)
echo $AMI_ID
```

