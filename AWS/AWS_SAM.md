# AWS Serverless Applicatino Model(AWS SAM)

AWS Serverless Application Model (AWS SAM) は、AWS でサーバーレスアプリケーションを構築するために使用できるオープンソースのフレームワークです。

- [AWS Serverless Applicatino Model(AWS SAM)](#aws-serverless-applicatino-modelaws-sam)
  - [プロジェクト作成](#プロジェクト作成)
    - [実行例](#実行例)
    - [language](#language)
  - [template.yaml](#templateyaml)
  - [ビルド](#ビルド)
    - [実行例](#実行例-1)
  - [ローカル実行](#ローカル実行)
    - [実行例](#実行例-2)
    - [デプロイ](#デプロイ)
      - [権限](#権限)
    - [削除](#削除)
    - [参考](#参考)
  - [公式](#公式)

## プロジェクト作成

``` bash
sam init --runtime ${language}
```

### 実行例

``` txt
$ sam init --runtime python3.9
Which template source would you like to use?
	1 - AWS Quick Start Templates
	2 - Custom Template Location
Choice: 1

Choose an AWS Quick Start application template
	1 - Hello World Example
	2 - Hello World Example With Powertools
	3 - Infrastructure event management
	4 - Multi-step workflow
	5 - Lambda EFS example
	6 - Serverless Connector Hello World Example
	7 - Multi-step workflow with Connectors
Template: 1

Based on your selections, the only Package type available is Zip.
We will proceed to selecting the Package type as Zip.

Based on your selections, the only dependency manager available is pip.
We will proceed copying the template using pip.

Would you like to enable X-Ray tracing on the function(s) in your application?  [y/N]: N

Would you like to enable monitoring using CloudWatch Application Insights?
For more info, please view https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch-application-insights.html [y/N]: N

Project name [sam-app]: 

    -----------------------
    Generating application:
    -----------------------
    Name: sam-app
    Runtime: python3.9
    Architectures: x86_64
    Dependency Manager: pip
    Application Template: hello-world
    Output Directory: .
    Configuration file: sam-app/samconfig.toml
    
    Next steps can be found in the README file at sam-app/README.md
        

Commands you can use next
=========================
[*] Create pipeline: cd sam-app && sam pipeline init --bootstrap
[*] Validate SAM template: cd sam-app && sam validate
[*] Test Function in the Cloud: cd sam-app && sam sync --stack-name {stack-name} --watch


SAM CLI update available (1.82.0); (1.81.0 installed)
To download: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html
```

### language

- ruby2.7
- java8
- java8.al2
- java11
- nodejs12.x
- nodejs14.x
- nodejs16.x
- nodejs18.x
- dotnet6
- dotnet5.0
- dotnetcore3.1
- python3.9
- python3.8
- python3.7
- go1.x

## template.yaml

``` yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: >
  sam-app

  Sample SAM Template for sam-app

# More info about Globals: https://github.com/awslabs/serverless-application-model/blob/master/docs/globals.rst
Globals:
  Function:
    Timeout: 3
    MemorySize: 128

Resources:
  HelloWorldFunction:
    Type: AWS::Serverless::Function # More info about Function Resource: https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#awsserverlessfunction
    Properties:
      CodeUri: hello_world/
      Handler: app.lambda_handler
      Runtime: python3.9
      Architectures:
        - x86_64
      Events:
        HelloWorld:
          Type: Api # More info about API Event Source: https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#api
          Properties:
            Path: /hello
            Method: get

Outputs:
  # ServerlessRestApi is an implicit API created out of Events key under Serverless::Function
  # Find out more about other implicit resources you can reference within SAM
  # https://github.com/awslabs/serverless-application-model/blob/master/docs/internals/generated_resources.rst#api
  HelloWorldApi:
    Description: "API Gateway endpoint URL for Prod stage for Hello World function"
    Value: !Sub "https://${ServerlessRestApi}.execute-api.${AWS::Region}.amazonaws.com/Prod/hello/"
  HelloWorldFunction:
    Description: "Hello World Lambda Function ARN"
    Value: !GetAtt HelloWorldFunction.Arn
  HelloWorldFunctionIamRole:
    Description: "Implicit IAM Role created for Hello World function"
    Value: !GetAtt HelloWorldFunctionRole.Arn
```

## ビルド

``` bash
# Runtimeバージョンを用意しておく。
sam build
```

### 実行例

``` txt
$ sam build
Starting Build use cache
Manifest file is changed (new hash: 3298f13049d19cffaa37ca931dd4d421) or dependency folder (.aws-sam/deps/59e97b5f-957d-401b-bf78-af84bbce2471) is missing for (HelloWorldFunction), downloading dependencies and copying/building source
Building codeuri: /home/ubuntuuser/environment/tmp/sam-app/sam-app/hello_world runtime: python3.9 metadata: {} architecture: x86_64 functions: HelloWorldFunction
Running PythonPipBuilder:CleanUp
Running PythonPipBuilder:ResolveDependencies
Running PythonPipBuilder:CopySource
Running PythonPipBuilder:CopySource

Build Succeeded

Built Artifacts  : .aws-sam/build
Built Template   : .aws-sam/build/template.yaml

Commands you can use next
=========================
[*] Validate SAM template: sam validate
[*] Invoke Function: sam local invoke
[*] Test Function in the Cloud: sam sync --stack-name {{stack-name}} --watch
[*] Deploy: sam deploy --guided
```

## ローカル実行

``` bash
sam local start-api
```

### 実行例

``` json
$ curl localhost:3000/hello
{"message": "hello world"}
```

### デプロイ

``` bash
# デプロイ権限が必要。
sam deploy --guided
```

#### 権限

- デフォルトで作成されるプロジェクトで必要なもの
    - AWSCloudFormationFullAccess
    - AWSLambda_FullAccess
    - IAMFullAccess
    - AmazonAPIGatewayAdministrator
    - AmazonS3FullAccess

### 削除

```bash
sam delete
```

### 参考

- [チュートリアル](https://docs.aws.amazon.com/ja_jp/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html)
- [AWS SAM を使用するための IAM ポリシー:のべラボ.blog](https://nobelabo.hatenablog.com/entry/2022/07/31/142738)
- [AWS SAMを使ってみる:Qiita](https://qiita.com/spring_i/items/e087905a82c40cf900a0)

## 公式

- [デベロッパーガイド](https://docs.aws.amazon.com/ja_jp/serverless-application-model/latest/developerguide/what-is-sam.html)