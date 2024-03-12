# Azure Pipeline

- [Azure Pipeline](#azure-pipeline)
  - [Pipelineでリポジトリ内のshを実行し、出力結果をpublishにする](#pipelineでリポジトリ内のshを実行し出力結果をpublishにする)
    - [azure-pipeline.yml](#azure-pipelineyml)
    - [app.py](#apppy)
    - [app.sh](#appsh)

## Pipelineでリポジトリ内のshを実行し、出力結果をpublishにする

### azure-pipeline.yml

``` yml
trigger:
  branches:
    include:
      - feature/*
      - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: UsePythonVersion@0
    inputs:
      versionSpec: '3.x'
      addToPath: true

  - script: chmod +x ./app.sh
    displayName: 'Make app.sh executable'

  - bash: ./app.sh
    displayName: 'Run app.sh'

  - task: PublishPipelineArtifact@1
    inputs:
      targetPath: '$(Build.SourcesDirectory)/export'
      artifact: 'exported_files'
      publishLocation: 'pipeline'
```

### app.py

``` python
import datetime

def main():
    print(datetime.datetime.now())

if __name__ == "__main__":
    main()
```

### app.sh

``` bash
#!/bin/bash

mkdir export

filename=`uuidgen`

python app.py > export/$filename
```
