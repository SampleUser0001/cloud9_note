# Gradle

- [Gradle](#gradle)
  - [init](#init)
    - [参考](#参考)
  - [実行](#実行)
  - [VSCodeの補完が効かないとき](#vscodeの補完が効かないとき)
  - [JUnit実行時にSystem.out.printlnが表示されない](#junit実行時にsystemoutprintlnが表示されない)
  - [JUnitのNG内容が見たい](#junitのng内容が見たい)

## init

``` bash
# gradle_app=
mkdir ${gradle_app}
gradle init
```

``` bash
gradle init

Select type of project to generate:
  1: basic
  2: application
  3: library
  4: Gradle plugin
Enter selection (default: basic) [1..4] 2

Select implementation language:
  1: C++
  2: Groovy
  3: Java
  4: Kotlin
  5: Scala
  6: Swift
Enter selection (default: Java) [1..6] 3

Split functionality across multiple subprojects?:
  1: no - only one application project
  2: yes - application and library projects
Enter selection (default: no - only one application project) [1..2] 

Select build script DSL:
  1: Groovy
  2: Kotlin
Enter selection (default: Groovy) [1..2] 1

Generate build using new APIs and behavior (some features may change in the next minor release)? (default: no) [yes, no] 
Select test framework:
  1: JUnit 4
  2: TestNG
  3: Spock
  4: JUnit Jupiter
Enter selection (default: JUnit Jupiter) [1..4] 1

Project name (default: demo): 
Source package (default: demo): ittimfn.gradle.demo

> Task :init
Get more help with your project: https://docs.gradle.org/7.6/samples/sample_building_java_applications.html

BUILD SUCCESSFUL in 36s
2 actionable tasks: 2 executed
```

### 参考

- [Building Java Applications Sample:Gradle](https://docs.gradle.org/current/samples/sample_building_java_applications.html)

## 実行

``` bash
gradle run
# または下記。
# ./gradlew run
```

## VSCodeの補完が効かないとき

- 拡張機能の再インストールを行う。

## JUnit実行時にSystem.out.printlnが表示されない

``` groovy
tasks.named('test') {
    // Use JUnit Platform for unit tests.
    useJUnitPlatform()
    testLogging {
        showStandardStreams = true
    }
}
```

## JUnitのNG内容が見たい

- ```app/build/reports/tests/test/index.html```をブラウザで開く。
    - VSCode拡張機能の[Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)をインストールしている場合は、対象のファイルを選択して、「Go Live」を押下する。