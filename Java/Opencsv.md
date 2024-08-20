# Opencsv

- [Opencsv](#opencsv)
  - [pom.xml](#pomxml)
  - [行単位で読み込む](#行単位で読み込む)

## pom.xml

```xml
<dependency>
    <groupId>com.opencsv</groupId>
    <artifactId>opencsv</artifactId>
    <version>5.9</version>
</dependency>
```

## 行単位で読み込む

``` java
try (CSVReader csvReader = new CSVReader(new InputStreamReader(new FileInputStream(this.csvPath.toString()), charset))) {
    return
        csvReader.readAll() // readAllの戻り値はList<String[]>。
                 .stream() 
                 .skip(1) // ヘッダ行を読み飛ばす
                 // 任意の終端処理
} catch (CsvException | IOException e) {
    logger.error(e);
    throw e;
}
```
